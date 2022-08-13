import 'package:flutter/material.dart';

import 'components/products_list.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({Key? key, required this.kind}) : super(key: key);

  final String kind;
  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return AddedProductsScreen(kind: widget.kind);
  }
}
