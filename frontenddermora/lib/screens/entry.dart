// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/chat/chat_screen.dart';
import 'package:frontenddermora/screens/home/homepage_screen.dart';
import 'package:frontenddermora/screens/profile/profile_screen.dart';
import 'package:frontenddermora/screens/self_scanning/self_scanning_screen.dart';
import 'package:frontenddermora/services/shared_service.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/api_service.dart';
import '../util/styles.dart';

class EntryWidget extends StatefulWidget {
  EntryWidget({Key? key, required this.selectedIndex}) : super(key: key);
  late int selectedIndex;
  @override
  State<EntryWidget> createState() => _EntryWidgetState();
}

class _EntryWidgetState extends State<EntryWidget> {
  final screens = [
    HomePageScreen(),
    SelfScanningScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: screens,
        index: widget.selectedIndex,
      ),
      bottomNavigationBar: buildNavigationBar(),
    );
  }

  SliverAppBar buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      // Color(0xFFCCD9FD),
      toolbarHeight: 90,
      forceElevated: true,
      elevation: 4,
      shadowColor: kSecBlue,
      shape: const RoundedRectangleBorder(
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
                'Hello, Furqan',
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
              // ignore: prefer_const_literals_to_create_immutables
              decoration: BoxDecoration(boxShadow: [
                const BoxShadow(blurRadius: 7, spreadRadius: 3, color: kSecBlue)
              ], shape: BoxShape.circle, color: kSecBlue.withOpacity(0.1)),
              child: Image.asset(
                "assets/images/avatar.png",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 40,
            )
          ],
        )
      ],
    );
  }

  BottomNavigationBar buildNavigationBar() {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: (value) => {
        if (value == 4)
          {SharedService.logout(context)}
        else
          {
            setState(() {
              widget.selectedIndex = value;
            })
          }
      },
      type: BottomNavigationBarType.fixed,
      fixedColor: kSecBlue,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            color: kSecBlue,
          ),
          activeIcon: Icon(
            Icons.home,
            color: kSecBlue,
          ),
          label: "Home",
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.camera_alt_outlined,
            color: kSecBlue,
          ),
          activeIcon: Icon(
            Icons.camera_alt,
            color: kSecBlue,
          ),
          label: "Camera",
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.messenger_outline_rounded,
            color: kSecBlue,
          ),
          activeIcon: Icon(
            Icons.messenger,
            color: kSecBlue,
          ),
          label: "Chats",
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
            color: kSecBlue,
          ),
          activeIcon: Icon(
            Icons.person,
            color: kSecBlue,
          ),
          label: "Profile",
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.logout_outlined,
            color: kSecBlue,
          ),
          activeIcon: Icon(
            Icons.logout,
            color: kSecBlue,
          ),
          label: "Logout",
        ),
      ],
    );
  }
}
