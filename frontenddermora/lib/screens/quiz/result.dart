// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/entry.dart';
import 'package:frontenddermora/util/styles.dart';

class Result extends StatelessWidget {
  final num resultScore;
  final void Function() resetHandler;
  final String resultText;

  Result(this.resultScore, this.resultText, this.resetHandler);

//Remark Logic
  String get resultPhrase {
    var startingText =
        'Your Skin Type is ${resultScore.toStringAsFixed(2)}% ... ';

    return startingText;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Image.asset(
              'assets/images/profile.png',
              width: screenWidth * 0.3,
              height: screenHeight * 0.3,
              fit: BoxFit.contain,
            ),
            flex: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                resultPhrase,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Text(
              '$resultText Skin',
              style: TextStyle(
                  fontSize: 36, fontWeight: FontWeight.bold, color: kSecBlue),
              textAlign: TextAlign.center,
            ),
            flex: 2,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Color(0xFF9DCEFF),
                      Color(0XFF92A3FD),
                    ],
                  ),
                  color: Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(315, 60)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(3),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EntryWidget(selectedIndex: 0)),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      "Home Page",
                      style: TextStyle(
                        fontSize: 18,
                        // fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ); //Center
  }
}
