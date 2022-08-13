import 'package:flutter/material.dart';
import 'package:frontenddermora/util/styles.dart';
import '../models/Gender.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'CustomRadio.dart';

class GenderSelector extends StatefulWidget {
  const GenderSelector({Key? key, required this.genders}) : super(key: key);

  final List<Gender> genders;
  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    return SizedBox(
        height: screenWidth * 0.13,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.genders.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 30,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                splashColor: kSecBlue,
                onTap: () {
                  setState(() {
                    widget.genders
                        .forEach((gender) => gender.isSelected = false);
                    widget.genders[index].isSelected = true;
                  });
                },
                child: CustomRadio(widget.genders[index]),
              );
            }));
  }
}
