// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/routine/components/search_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../services/api_routine.dart';
import '../../../util/styles.dart';
import '../models/products.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key, required this.label, required this.addItem})
      : super(key: key);

  String label;
  void Function(dynamic product, String label) addItem;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Products> products = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final products = await ProductsApi.getAllProducts();
    setState(() => this.products = products);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xF04967FF),
                Color(0xFF8CC1F7),
              ],
              begin: const FractionalOffset(0.0, 0.4),
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: buildSearch(),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(70))),
                  child: products.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                            color: kSecBlue,
                            size: 50,
                          )),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];

                              return buildProduct(product);
                            },
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onClicked: searchProduct,
      );

  Future searchProduct(String query) async => debounce(() async {
        print(query);
        final products = await ProductsApi.getProducts(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.products = products;
        });
      });

  Widget buildProduct(Products product) => ListTile(
        leading: Image.network(
          product.heroImage,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        trailing: InkWell(
          onTap: () {
            widget.addItem({
              "image": product.heroImage,
              "label": product.displayName,
              "kind": widget.label.toLowerCase().trim()
            }, widget.label.trim());
          },
          child: Text("Add",
              style: GoogleFonts.poppins(
                color: klightGrey.withOpacity(0.7),
                decoration: TextDecoration.underline,
                fontSize: 12.0,
              )),
        ),
        title: Text(product.displayName),
        subtitle: Text(product.brandName),
      );
}
