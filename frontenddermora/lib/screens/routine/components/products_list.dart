// ignore_for_file: prefer_const_constructors

import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/home/homepage_screen.dart';
import 'package:frontenddermora/screens/routine/components/single_product.dart';
import 'package:frontenddermora/screens/routine/components/edit_routine.dart';
import 'package:frontenddermora/util/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../services/api_routine.dart';
import '../../../services/chatting_service.dart';
import '../models/routine_response_model.dart';

class AddedProductsScreen extends StatefulWidget {
  const AddedProductsScreen({Key? key, required this.kind}) : super(key: key);

  final String kind;
  @override
  State<AddedProductsScreen> createState() => _AddedProductsScreenState();
}

class _AddedProductsScreenState extends State<AddedProductsScreen> {
  List<Map<String, dynamic>> list = [];
  RoutineResponseModel? routineData;
  @override
  void initState() {
    _get();
    super.initState();
  }

  _get() async {
    RoutineResponseModel? routine = await ProductsApi.getRoutine();
    List<Map<String, dynamic>> list2 = [];
    if (widget.kind == "morning") {
      for (ListProducts product in routine!.data.morningRoutine.products) {
        var flag = 1;
        for (int i = 0; i < list2.length; i++) {
          if (product.kind == list2[i]["label"]) {
            flag = 0;
            list2[i][product.kind].add({
              "image": product.image,
              "label": product.label,
              "kind": product.kind,
            });
          }
        }
        if (flag == 1) {
          list2.add({
            "label": product.kind,
            product.kind: [
              {
                "image": product.image,
                "label": product.label,
                "kind": product.kind,
              }
            ],
          });
        }
      }
    } else {
      for (ListProducts product in routine!.data.nightRoutine.products) {
        var flag = 1;
        for (int i = 0; i < list2.length; i++) {
          if (product.kind == list2[i]["label"]) {
            flag = 0;
            list2[i][product.kind].add({
              "image": product.image,
              "label": product.label,
              "kind": product.kind,
            });
          }
        }
        if (flag == 1) {
          list2.add({
            "label": product.kind,
            product.kind: [
              {
                "image": product.image,
                "label": product.label,
                "kind": product.kind,
              }
            ],
          });
        }
      }
    }
    setState(() {
      routineData = routine;
      list = list2;
    });
  }

  var data = [];

  void reomveItem(ele, label, index) async => {
        setState(() {
          list[index][label].remove(ele);
        }),
        for (var element in list)
          {
            for (var i in element[element["label"]]) data.add(i),
          },
        await ProductsApi.addProductToRoutine(data, widget.kind),
        data.clear(),
      };
  var response;
  void addItem(product, label) async => {
        setState(() {
          var flag = 1;
          for (int i = 0; i < list.length; i++) {
            if (product["kind"] == list[i]["label"]) {
              flag = 0;
              list[i][product["kind"]]!.add(product);
            }
          }
          if (flag == 1) {
            list.add({
              "label": product["kind"],
              product["kind"]: [
                {
                  "image": product["image"],
                  "label": product["label"],
                  "kind": product["kind"],
                }
              ],
            });
          }
        }),
        for (var element in list)
          {
            for (var i in element[element["label"]]) data.add(i),
          },
        response = await ProductsApi.addProductToRoutine(data, widget.kind),
        data.clear(),
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            title: response == "no"
                ? Text("Something went wrong")
                : Text("Success"),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            actionsOverflowButtonSpacing: 20,
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kSecBlue)),
              ),
            ],
            content: Text("Saved successfully"),
          ),
        ),
      };

  bool value = true;
  @override
  void dispose() {
    setState(() {
      list = [];
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Column(
                  children: [
                    Row(children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePageScreen()),
                            );
                          },
                          icon: Icon(Icons.arrow_back, color: Colors.white)),
                      Expanded(child: Container()),
                      //SizedBox(width: 20),
                      Text(
                          widget.kind == "morning"
                              ? 'Morning Routine'
                              : 'Night Routine',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          )),
                      Expanded(child: Container()),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(99.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          // elevation: MaterialStateProperty.all(3),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditRoutineListScreen(addItem: addItem)),
                          );
                        },
                        child: Text("Edit",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            )),
                      ),
                    ]),
                  ],
                )),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(70))),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: routineData == null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                          color: kSecBlue,
                          size: 50,
                        )),
                      )
                    : list.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: EmptyWidget(
                              hideBackgroundAnimation: true,
                              image: null,
                              packageImage: PackageImage.Image_1,
                              title: 'No Products',
                              subTitle: 'Add your routine products now!',
                              titleTextStyle: TextStyle(
                                fontSize: 22,
                                color: kSecBlue,
                                fontWeight: FontWeight.w500,
                              ),
                              subtitleTextStyle: TextStyle(
                                fontSize: 14,
                                color: Color(0xffabb8d6),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 10, bottom: 30),
                                child: Row(
                                  children: [
                                    Text("5 Steps",
                                        style: GoogleFonts.poppins(
                                          color: kBlack,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.0,
                                        )),
                                  ],
                                ),
                              ),
                              for (int i = 0; i < list.length; i++)
                                SingleProduct(
                                    label: list[i]["label"].toString(),
                                    products: list[i][list[i]["label"]],
                                    index: i,
                                    remove: reomveItem),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                width: 270,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      offset: Offset(4, 4),
                                      blurRadius: 10,
                                      color: Color(0xFFB8BFCE).withOpacity(.2),
                                    ),
                                    BoxShadow(
                                      offset: Offset(-3, 0),
                                      blurRadius: 15,
                                      color: Color(0xFFB8BFCE).withOpacity(.1),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
