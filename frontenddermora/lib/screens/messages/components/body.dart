// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/auth/models/Profile_model.dart';
import 'package:frontenddermora/screens/chat/model/chat.dart';
import 'package:frontenddermora/screens/chat/model/chat_response_model.dart';
import 'package:frontenddermora/screens/messages/components/chat_textField.dart';
import 'package:frontenddermora/screens/messages/components/message.dart';
import 'package:frontenddermora/screens/messages/models/messages.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.userData,
    required this.chatsData,
    required this.closeChat,
    required this.messagesData,
  }) : super(key: key);

  final Profile userData;
  final Chat chatsData;
  final bool closeChat;
  final ChatResponseModel messagesData;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Socket socket; //initalize the Socket.IO Client Object
  List<ChatMessage> chatMessages = [];
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _get();

    WidgetsBinding.instance?.addPostFrameCallback((_) => {
          _controller.animateTo(
            0.0,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          )
        });
    socket = io("https://dermora.herokuapp.com/", <String, dynamic>{
      // socket = io("http://192.168.43.143:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket.connect(); //connect the Socket.IO Client to the Server
    initializeSocket();
    socket.emit('joinChat', widget.chatsData.chatId);
  }

  void initializeSocket() {
    //SOCKET EVENTS
    // --> listening for connection
    socket.on('connect', (data) {
      print("client is connected to the socket");
      print(socket.connected);
    });

    //listen for incoming messages from the Server.
    socket.on('newMessage', (info) {
      setState(() {
        chatMessages.add(ChatMessage(
          content: info["content"],
          chatId: info["chatId"],
          timeStamp: info["timestamp"],
          sender: info["sender"],
          isSender: info["sender"] == widget.userData.data.id,
          senderImage: info["senderImage"],
          friendId: info["friendId"],
        ));
      });
    });

    //listens when the client is disconnected from the Server
    socket.on('disconnect', (data) {
      print('disconnect');
    });
  }

  _get() async {
    setState(() {
      for (var element in widget.messagesData.messages) {
        Users senderImage = widget.messagesData.chat.users
            .singleWhere((e) => e.id == element.sender);

        chatMessages.add(
          ChatMessage(
            content: element.content,
            chatId: widget.messagesData.chat.id,
            timeStamp: element.timestamp,
            sender: element.sender,
            isSender: element.sender == widget.userData.data.id,
            senderImage: senderImage.image,
            friendId: widget.messagesData.friendData.id,
          ),
        );
        print(chatMessages[0]);
      }
    });
  }

  @override
  void dispose() {
    socket
        .disconnect(); // --> disconnects the Socket.IO client once the screen is disposed
    socket.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.closeChat);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08, vertical: 30),
            child: ListView.builder(
              controller: _controller,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              reverse: true,
              cacheExtent: 1000,
              itemCount: chatMessages.length,
              itemBuilder: (context, index) => Message(
                  message: chatMessages[chatMessages.length - index - 1],
                  image: widget.chatsData.image),
            ),
          ),
        ),
        widget.closeChat
            ? Text("")
            : ChatTextFiled(
                screenWidth: screenWidth,
                socket: socket,
                chatsData: widget.chatsData,
                userData: widget.userData),
      ],
    );
  }
}
