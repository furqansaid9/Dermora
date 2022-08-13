// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:frontenddermora/doctor_screens/profile/shifts.dart';
import 'package:frontenddermora/screens/primary_questions/components/reusableButton.dart';
import 'package:frontenddermora/util/styles.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../services/api_service.dart';
import '../../auth/models/Profile_model.dart';
import '../../primary_questions/models/concerns.dart';
import 'button.dart';
import 'profile_data.dart';
import 'profile_details.dart';
import 'skin_concerns.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Concern> concerns = [];
  Profile? userData;

  @override
  void initState() {
    super.initState();
    _get();
  }

  _get() async {
    Profile? user1 = await APIService.getUserData();
    setState(() {
      userData = user1!;
    });
    setState(() {
      for (var element in userData!.data.userInfo.skinConcerns) {
        concerns.add(
          Concern(element, false),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    List<Map> list = [
      {
        "image": "assets/images/moon.png",
        "amount": "1",
        "label": "Evening logs"
      },
      {
        "image": "assets/images/sun.png",
        "amount": "2",
        "label": "Morning logs"
      },
      {"image": "assets/images/cream.png", "amount": "4", "label": "Routines"},
    ];

    return Column(
      children: [
        ProfileDetails(screenWidth: screenWidth, userData: userData!),
        userData!.data.kind == "user"
            ? ProfileData(screenWidth: screenWidth, list: list)
            : Text(""),
        userData!.data.kind == "user"
            ? SkinConcerns(screenWidth, concerns)
            : Text(""),
        userData!.data.kind == "doctor" ? Shifts() : Text("")
      ],
    );
  }
}
