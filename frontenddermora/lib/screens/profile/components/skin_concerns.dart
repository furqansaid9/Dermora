// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/auth/models/Profile_model.dart';
import 'package:frontenddermora/util/styles.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../primary_questions/models/concerns.dart';
import 'button.dart';

Padding SkinConcerns(double screenWidth, List<Concern> concerns) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 40, horizontal: screenWidth * 0.05),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            "Your skin concerns",
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 4,
          children: List.generate(
            concerns.length,
            (index) {
              return Center(
                child: Flexible(child: ReuseableButton_2(concerns[index])),
              );
            },
          ),
        )
      ],
    ),
  );
}
