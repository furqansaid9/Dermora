// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/auth/models/Profile_model.dart';
import 'package:frontenddermora/screens/chat/model/chat.dart';
import 'package:frontenddermora/screens/chat/model/chat_response_model.dart';
import 'package:frontenddermora/util/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import '../../services/chatting_service.dart';
import '../chat/model/chatInfo_response_model.dart';
import 'components/body.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen(
      {Key? key,
      required this.userData,
      required this.chatsData,
      required this.messagesData})
      : super(key: key);

  final Profile userData;
  final Chat chatsData;
  final ChatResponseModel messagesData;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  String remainingTime = "";
  bool closeChat = false;
  late Timer _timer;
  // Timer(const Duration(seconds: 5), () => print('Timer finished'));

  @override
  void initState() {
    super.initState();

    if (widget.messagesData.chat.endTime != null) {
      var end = DateTime.parse(widget.messagesData.chat.endTime!);
      var now = DateTime.now();
      changeChatStatus(end, now); // update according to the api
      if (!widget.messagesData.chat.isClosed) {
        updateTimeDifference(end, now);
        _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
          var end = DateTime.parse(widget.messagesData.chat.endTime!);
          var now = DateTime.now();
          endTimer(timer, end, now); // decide if the timer should stop or not
          calculateDiffrence(end, now); // calculate the time difference
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(
          chatsData: widget.chatsData,
          userData: widget.userData,
          messagesData: widget.messagesData,
          closeChat: closeChat),
    );
  }

  AppBar buildAppBar() {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: screenWidth * 0.2,
      leading: Padding(
        padding: EdgeInsets.only(top: screenWidth * 0.1),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: kSecBlue),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(top: screenWidth * 0.1),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.chatsData.image == ""
                  ? AssetImage("assets/images/profile.png")
                  : AssetImage(widget.chatsData.image),
              radius: 20,
            ),
            SizedBox(
              width: screenWidth * 0.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.chatsData.name}",
                  style: GoogleFonts.abhayaLibre(
                      color: Colors.black, fontSize: 20),
                ),
                Row(
                  children: [
                    Text(
                      widget.messagesData.chat.isClosed
                          ? ""
                          : "Time Remaining: ",
                      style: GoogleFonts.abhayaLibre(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      remainingTime,
                      style: GoogleFonts.roboto(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  changeChatStatus(end, now) {
    print("changing status from the function");
    if (now.isAfter(end) && widget.messagesData.chat.isClosed) {
      setState(() {
        remainingTime = "Time is up";
        closeChat = true;
        _updateStatus();
      });
      print(remainingTime);
    }
  }

  _updateStatus() async {
    var res = await APIChatService.updateChatStatus(widget.chatsData.chatId);
  }

  updateTimeDifference(end, now) {
    if (widget.messagesData.chat.isStarted) {
      var dif = end.difference(now);
      if (!widget.messagesData.chat.isClosed)
        setState(() {
          remainingTime = dif.inMinutes.toString();
        });
    }
  }

  calculateDiffrence(end, now) {
    if (widget.messagesData.chat.isStarted) {
      var dif = end.difference(now);
      setState(() {
        remainingTime = dif.inMinutes.toString();
      });
    }
  }

  endTimer(timer, end, now) {
    if (now.isAfter(end)) {
      print("done");
      timer.cancel();
      setState(() {
        _updateStatus();
        remainingTime = "Time is up";
        closeChat = true;
      });
    }
  }
}
