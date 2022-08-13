import 'package:flutter/material.dart';
import 'package:frontenddermora/util/styles.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final Future Function(String) onClicked;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 42,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: style.color),
                suffixIcon: widget.text.isNotEmpty
                    ? GestureDetector(
                        child: Icon(Icons.close, color: style.color),
                        onTap: () {
                          controller.clear();
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      )
                    : null,
                hintText: "Product Name",
                hintStyle: style,
                border: InputBorder.none,
              ),
              style: style,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99.0),
                  ),
                ),

                backgroundColor: MaterialStateProperty.all(Colors.white),
                // elevation: MaterialStateProperty.all(3),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                widget.onClicked(controller.text);
              },
              child: const Text(
                "Search",
                style: TextStyle(color: kSecBlue),
              )),
        )
      ],
    );
  }
}
