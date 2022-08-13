// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/styles.dart';

class SingleProduct extends StatefulWidget {
  SingleProduct({
    Key? key,
    required this.label,
    required this.products,
    required this.remove,
    required this.index,
  }) : super(key: key);

  final String label;
  final products;
  int index;
  void Function(dynamic ele, dynamic label, dynamic index) remove;

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 40, bottom: 30),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 48,
                ),
                Text(
                    widget.label.substring(0, 1).toUpperCase() +
                        widget.label.substring(1).toLowerCase(),
                    style: GoogleFonts.poppins(
                      color: kBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                    )),
                Expanded(child: Container()),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            for (var ele in widget.products)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline_rounded, size: 35),
                      onPressed: () {
                        widget.remove(ele, widget.label, widget.index);
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            offset: const Offset(4, 4),
                            blurRadius: 5,
                            color: klightGrey.withOpacity(.3),
                          )
                        ],
                      ),
                      child: Image.network(
                        ele["image"],
                        height: 50,
                        width: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Container(
                          padding: const EdgeInsets.only(right: 50),
                          child: Text(ele["label"],
                              style: GoogleFonts.poppins(
                                color: klightGrey.withOpacity(0.6),
                                fontSize: 12.0,
                              ))),
                    )
                  ],
                ),
              )
          ],
        ));
  }
}
