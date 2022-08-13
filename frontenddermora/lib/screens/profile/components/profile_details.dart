// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/auth/models/Profile_model.dart';
import 'package:frontenddermora/util/styles.dart';

import '../../../services/api_service.dart';
import '../../auth/models/login_response_model.dart';
import '../model/profile.dart';
import 'package:screen_loader/screen_loader.dart';

class ProfileDetails extends StatefulWidget {
  ProfileDetails({
    Key? key,
    required this.screenWidth,
    required this.userData,
  }) : super(key: key);

  final double screenWidth;
  final Profile userData;

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  // late Profile userData;
  List demoProfile = [];

  @override
  void initState() {
    super.initState();
    demoProfile.add(ProfileData(
      label: "Name",
      text: widget.userData.data.fullName,
    ));
    demoProfile.add(ProfileData(
      label: "Contact",
      text: widget.userData.data.phone,
    ));
    demoProfile.add(ProfileData(
        label: "Location",
        text: widget.userData.data.address.city == ""
            ? "Unknown"
            : widget.userData.data.address.city));
    demoProfile.add(ProfileData(
        label: widget.userData.data.kind == "doctor" ? "" : "Skin Type",
        text: widget.userData.data.kind == "doctor"
            ? ""
            : widget.userData.data.userInfo.skinType == ""
                ? "Unknown"
                : widget.userData.data.userInfo.skinType));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/images/rectangle.png",
                    width: widget.screenWidth * 0.49,
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: EdgeInsets.all(widget.screenWidth * 0.09),
                    child: Column(
                      children: [
                        Image.asset(
                          widget.userData.data.image == ""
                              ? "assets/images/profile.png"
                              : widget.userData.data.image,
                          width: widget.screenWidth * 0.3,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.userData.data.fullName,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: widget.screenWidth * 0.05, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: demoProfile.length,
                    itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            demoProfile[index].label,
                            style: normalStyleBlack,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            demoProfile[index].text,
                            style: normalStyle,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
