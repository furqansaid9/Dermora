// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontenddermora/services/api_service.dart';
import 'package:frontenddermora/util/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../auth/models/Profile_model.dart';
import './components/DoctorsDetails.dart';
import './components/cardDetails.dart';
import 'components/body.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreen();
}

class _HomePageScreen extends State<HomePageScreen> {
  int _selectedIndex = 1;
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
  }

  get screenWidth => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userData == null
          ? Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                color: kSecBlue,
                size: 50,
              )),
            )
          : NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                buildAppBar(userData!),
              ],
              body: Body(),
            ),
    );
  }

  SliverAppBar buildAppBar(Profile userData) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      // Color(0xFFCCD9FD),
      toolbarHeight: 90,
      forceElevated: true,
      elevation: 4,
      shadowColor: kSecBlue,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(70),
        bottomLeft: Radius.circular(70),
      )),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(children: [
              Text(
                'Hello, ${userData.data.fullName}',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Welcome!",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 12.0,
                ),
              ),
            ]),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(blurRadius: 7, spreadRadius: 3, color: kSecBlue)
              ], shape: BoxShape.circle, color: kSecBlue.withOpacity(0.1)),
              child: Image.asset(
                userData.data.image == ""
                    ? "assets/images/profile.png"
                    : userData.data.image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: 40,
            )
          ],
        )
      ],
    );
  }
}
