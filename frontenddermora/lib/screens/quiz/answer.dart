// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:frontenddermora/util/styles.dart';

class Answer extends StatelessWidget {
  final void Function() selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
          width: double.infinity,
          height: screenWidth * 0.15,
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: kSecBlue, width: 1),
              borderRadius: BorderRadius.circular(10.25),
            ),
            child: Container(
              width: screenWidth * 0.3,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: selectHandler,
                      child: Text(
                        answerText,
                        style: const TextStyle(
                          fontSize: 14,
                          color: kSecBlue,
                        ),
                        softWrap: true,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          // RaisedButton(
          //   color: const Color(0xFF00E676),
          //   textColor: Colors.white,
          //   child: Text(answerText),
          //   onPressed: selectHandler,
          // ), //RaisedButton
          ),
    ); //Container
  }
}
