// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:frontenddermora/util/styles.dart';

class ProfileData extends StatelessWidget {
  const ProfileData({
    Key? key,
    required this.screenWidth,
    required this.list,
  }) : super(key: key);

  final double screenWidth;
  final List<Map> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var ele in list)
            Flexible(
              child: Container(
                width: screenWidth * 0.27,
                padding: EdgeInsets.symmetric(
                  // horizontal: screenWidth * 0.03,
                  vertical: 25,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                  border: Border.all(width: 1.0, color: kSecBlue),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFC58BF2).withOpacity(0.1),
                      ),
                      child: Image.asset(
                        ele["image"],
                        width: null,
                        height: null,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ele["amount"],
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ele["label"],
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
