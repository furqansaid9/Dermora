// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/styles.dart';

class Shifts extends StatelessWidget {
  const Shifts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: _buildTextTodaysPlan(),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: _buildMorningRoutine(),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: _buildNightRoutine(),
        ),
      ],
    ));
  }
}

Widget _buildTextTodaysPlan() {
  return Container(
    alignment: Alignment.centerLeft,
    child: Text(
      "Availability Schedule",
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );
}

Widget _buildMorningRoutine() {
  return Container(
    padding: const EdgeInsets.all(0),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(width: 1, color: kSecBlue),
      borderRadius: BorderRadius.circular(10.25),
      boxShadow: [
        BoxShadow(
          color: klightGrey.withOpacity(.8),
          offset: Offset(2, 4),
          blurRadius: 1,
          spreadRadius: 0,
        )
      ],
    ),
    child: ListTile(
      leading: Image.asset('assets/images/sun.png'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Morning Shift ",
              style: TextStyle(
                fontSize: 14,
                color: kSecBlue,
              ),
              softWrap: true,
              maxLines: 3,
              textAlign: TextAlign.center),
          SizedBox(height: 5.0),
          Text(
            "9:00 AM ",
            style: TextStyle(
              fontSize: 14,
              color: kSecBlue,
            ),
            softWrap: true,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.0),
          Text(
            "Thursday - Saturday",
            style: TextStyle(
              fontSize: 14,
              color: kSecBlue,
            ),
            softWrap: true,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Widget _buildNightRoutine() {
  return Container(
    padding: const EdgeInsets.all(0),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(width: 1, color: kSecBlue),
      borderRadius: BorderRadius.circular(10.25),
      boxShadow: [
        BoxShadow(
          color: klightGrey.withOpacity(.8),
          offset: Offset(2, 4),
          blurRadius: 1,
          spreadRadius: 0,
        )
      ],
    ),
    child: ListTile(
      leading: Image.asset('assets/images/moon.png'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Night Shift ",
            style: TextStyle(
              fontSize: 14,
              color: kSecBlue,
            ),
            softWrap: true,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.0),
          Text(
            "10:00 PM ",
            style: TextStyle(
              fontSize: 14,
              color: kSecBlue,
            ),
            softWrap: true,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.0),
          Text(
            "Monday-Tuesday ",
            style: TextStyle(
              fontSize: 14,
              color: kSecBlue,
            ),
            softWrap: true,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
