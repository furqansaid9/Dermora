// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontenddermora/doctor_screens/doctorEntery.dart';
import 'package:frontenddermora/util/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:empty_widget/empty_widget.dart';

import '../../../screens/auth/models/Profile_model.dart';
import '../../../screens/chat/chat_screen.dart';
import '../../../screens/chat/model/chat.dart';
import '../../../screens/messages/message_screen.dart';
import '../../../services/api_service.dart';
import '../../../services/chatting_service.dart';

class DoctorsDetails extends StatefulWidget {
  DoctorsDetails({
    Key? key,
    required this.list,
    required this.userData,
  }) : super(key: key);

  final List<Map> list;
  Profile userData;
  @override
  State<DoctorsDetails> createState() => _DoctorsDetailsState();
}

class _DoctorsDetailsState extends State<DoctorsDetails> {
  late Socket socket;

  @override
  void initState() {
    super.initState();
    initializeSocket();
    socket.connect();
    socket.emit('joinNotificationRoom', widget.userData.data.id);
  }

  void initializeSocket() {
    socket = io("https://dermora.herokuapp.com/", <String, dynamic>{
      // socket = io("http://192.168.43.143:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.on('connect', (data) {
      print("client is connected to the socket");
    });
    socket.on('newFriendRequest', (data) {
      setState(() {
        widget.list.add({
          "friendId": data["id"],
          "image": data["image"],
          "label": data["name"],
          "Key": "${data["city"]}   ${data["age"]} years old",
          "time": "Request time ${data["time"]}",
          "isAccepted": false,
        });
      });
    });
    socket.on('disconnect', (data) {
      print('disconnect');
    });
  }

  @override
  void dispose() {
    socket
        .disconnect(); // --> disconnects the Socket.IO client once the screen is disposed
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.list.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 40),
            child: EmptyWidget(
              hideBackgroundAnimation: true,
              image: null,
              packageImage: PackageImage.Image_1,
              title: 'No Requests',
              subTitle: 'No requests available yet',
              titleTextStyle: TextStyle(
                fontSize: 22,
                color: kSecBlue,
                fontWeight: FontWeight.w500,
              ),
              subtitleTextStyle: TextStyle(
                fontSize: 14,
                color: Color(0xffabb8d6),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var ele in widget.list)
                  Container(
                    padding: const EdgeInsets.all(0),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          offset: Offset(4, 4),
                          blurRadius: 10,
                          color: Color(0xFFB8BFCE).withOpacity(.2),
                        ),
                        BoxShadow(
                          offset: Offset(-3, 0),
                          blurRadius: 15,
                          color: Color(0xFFB8BFCE).withOpacity(.1),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          child: Row(
                            children: [
                              Padding(padding: EdgeInsets.all(0)),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13)),
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [0.0, 1.0],
                                      colors: [
                                        Color(0xFF9DCEFF),
                                        Color(0XFF92A3FD),
                                      ],
                                    ),
                                    color: Colors.deepPurple.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(
                                    ele["image"] == ""
                                        ? "assets/images/profile.png"
                                        : ele["image"],
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ele["label"],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      ele["Key"],
                                      style: TextStyle(
                                          color: Color(0xFF8F8F8F),
                                          fontSize: 10),
                                    ),
                                    Text(
                                      ele["time"],
                                      style: TextStyle(
                                          color: Color(0xFF8F8F8F),
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 70),
                                    child: IconButton(
                                      iconSize: 20,
                                      color: kSecBlue,
                                      icon: Icon(
                                          Icons.chat_bubble_outline_rounded,
                                          size: 20),
                                      onPressed: () async {
                                        String message =
                                            await APIChatService.createChat(
                                                json.encode({
                                          "userId": ele["friendId"],
                                          "userImage": ele["image"],
                                          "userName": ele["label"],
                                          "id": widget.userData.data.id,
                                          "image": widget.userData.data.image,
                                          "name": widget.userData.data.fullName,
                                        }));

                                        socket.emit('requestAccepted', {
                                          ele["friendId"],
                                          widget.userData.data.id
                                        });

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DoctorEntryWidget(
                                                    selectedIndex: 1,
                                                  )),
                                        );
                                      },
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          );
  }
}
