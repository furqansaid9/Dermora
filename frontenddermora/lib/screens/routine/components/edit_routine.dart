// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/routine/components/products_list.dart';
import 'package:frontenddermora/screens/routine/components/search_product.dart';
import 'package:frontenddermora/util/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class EditRoutineListScreen extends StatefulWidget {
  EditRoutineListScreen({Key? key, required this.addItem}) : super(key: key);

  void Function(dynamic product, String label) addItem;
  @override
  State<EditRoutineListScreen> createState() => _EditRoutineListScreenState();
}

class _EditRoutineListScreenState extends State<EditRoutineListScreen> {
  List<Map> list = [
    {
      "label": "Cleanser ",
    },
    {
      "label": "Toner ",
    },
    {
      "label": "Treatment",
    },
    {
      "label": "Moisturizer",
    },
    {
      "label": "Sunscreen",
    },
  ];

  bool value = true;

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
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                      ),

                      Expanded(child: Container()),
                      //SizedBox(width: 20),
                      Text('Edit Routine',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          )),
                      Expanded(child: Container()),
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    for (var ele in list)
                      Container(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 48,
                                  ),
                                  Text(ele["label"],
                                      style: GoogleFonts.poppins(
                                        color: kBlack,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        stops: [0.0, 1.0],
                                        colors: [
                                          Color(0xF04967FF),
                                          Color(0xFF8CC1F7),
                                        ],
                                      ),
                                      color: Colors.deepPurple.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          offset: const Offset(4, 4),
                                          blurRadius: 5,
                                          color: klightGrey.withOpacity(.3),
                                        )
                                      ],
                                    ),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchScreen(
                                                        label: ele["label"],
                                                        addItem:
                                                            widget.addItem)),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Text("Add your Product",
                                      style: GoogleFonts.poppins(
                                        color: klightGrey.withOpacity(0.6),
                                        fontSize: 14.0,
                                      ))
                                ],
                              )
                            ],
                          )),
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
