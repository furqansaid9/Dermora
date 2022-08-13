import 'package:flutter/material.dart';
import 'package:frontenddermora/util/styles.dart';

import '../../primary_questions/models/concerns.dart';

class ReuseableButton_2 extends StatelessWidget {
  late Concern _concern;
  ReuseableButton_2(this._concern);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Card(
        color: _concern.isSelected ? kSecBlue.withOpacity(0.8) : Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: kSecBlue, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.grey,
        elevation: 5,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10.0),
          child: Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Text(
                    _concern.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        color: _concern.isSelected ? Colors.white : kSecBlue),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
