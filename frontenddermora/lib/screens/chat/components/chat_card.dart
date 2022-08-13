// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/chat/model/chat.dart';
import 'package:frontenddermora/util/styles.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.chat,
    required this.press,
  }) : super(key: key);
  final Chat chat;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: press,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 10),
        child: Row(
          children: <Widget>[
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: chat.image == ""
                      ? AssetImage("assets/images/profile.png")
                      : AssetImage(chat.image),
                  radius: 29,
                  backgroundColor: kSecBlue.withOpacity(0.4),
                ),
                // if (chat.status)
                //   Positioned(
                //     right: 0,
                //     bottom: 0,
                //     child: Container(
                //       height: 16,
                //       width: 16,
                //       decoration: BoxDecoration(
                //           color: kSecBlue,
                //           shape: BoxShape.circle,
                //           border: Border.all(
                //             color: Colors.white,
                //             width: 3,
                //           )),
                //     ),
                //   )
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: screenWidth * 0.03,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
