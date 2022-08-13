import 'package:flutter/material.dart';
import 'package:frontenddermora/util/styles.dart';
import '../models/concerns.dart';

class ReuseableButton extends StatelessWidget {
  late Concern _concern;
  ReuseableButton(this._concern);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Card(
        color: _concern.isSelected ? kSecBlue.withOpacity(0.8) : Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: kSecBlue, width: 1),
          borderRadius: BorderRadius.circular(10.25),
        ),
        child: Container(
          width: screenWidth * 0.3,
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
