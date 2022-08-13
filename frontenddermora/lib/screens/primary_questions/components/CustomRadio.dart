import 'package:flutter/material.dart';
import 'package:frontenddermora/util/styles.dart';
import '../models/Gender.dart';

class CustomRadio extends StatelessWidget {
  late Gender _gender;
  CustomRadio(this._gender);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    return Card(
        color: _gender.isSelected ? kSecBlue.withOpacity(0.8) : Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: kSecBlue, width: 1),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Container(
          width: screenWidth * 0.3,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                _gender.icon,
                color: _gender.isSelected ? Colors.white : kSecBlue,
                size: 30,
              ),
              const SizedBox(height: 10),
              Text(
                _gender.name,
                style: TextStyle(
                    color: _gender.isSelected ? Colors.white : kSecBlue),
              )
            ],
          ),
        ));
  }
}
