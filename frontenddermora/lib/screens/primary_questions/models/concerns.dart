import 'package:flutter/widgets.dart';

class Concern {
  String name;
  bool isSelected;

  Concern(this.name, this.isSelected);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['isSelected'] = isSelected;
    return _data;
  }
}
