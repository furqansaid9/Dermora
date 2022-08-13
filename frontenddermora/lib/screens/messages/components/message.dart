// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/messages/components/text_message.dart';
import 'package:frontenddermora/screens/messages/models/messages.dart';
import 'package:frontenddermora/util/styles.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
    required this.image,
  }) : super(key: key);

  final ChatMessage message;
  final String image;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(image),
            ),
            SizedBox(width: screenWidth * 0.05),
          ],
          TextMessage(message: message),
          // if (message.isSender) MessageStatusDot()
        ],
      ),
    );
  }
}

// class MessageStatusDot extends StatelessWidget {
//   final MessageStatus? status;

//   const MessageStatusDot({Key? key, this.status}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;

//     return Container(
//       margin: EdgeInsets.only(left: screenWidth * 0.03),
//       height: 12,
//       width: 12,
//       child: Icon(
//         status == MessageStatus.not_sent ? Icons.close : Icons.done,
//         size: 8,
//         color: Theme.of(context).scaffoldBackgroundColor,
//       ),
//     );
//   }
// }
