// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:frontenddermora/screens/chat/model/chat.dart';
import 'package:frontenddermora/screens/messages/message_screen.dart';
import 'package:frontenddermora/util/styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../config.dart';
import '../../../services/api_service.dart';
import '../../../services/chatting_service.dart';
import '../../auth/models/Profile_model.dart';
import '../model/chat_response_model.dart';
import 'chat_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List chatsData = [];
  Profile? userData;
  List<ChatResponseModel> messagesData = [];
  ChatResponseModel? loadingMessages;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    _get();
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    _get();
  }

  _get() async {
    Profile? user = await APIService.getUserData();
    setState(() {
      userData = user!;
      chatsData.clear();
      messagesData.clear();
    });
    for (var element in user!.data.friends) {
      ChatResponseModel? messages =
          await APIChatService.getChat(element.chatId);
      setState(() {
        loadingMessages = messages;
        messagesData.add(messages!);
      });

      setState(() {
        chatsData.add(Chat(
          name: element.name,
          image: element.image,
          status: element.status,
          chatId: element.chatId,
          friendId: element.id,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return userData == null
        ? Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
              color: kSecBlue,
              size: 50,
            )),
          )
        : Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05, vertical: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.07),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.1,
                            ),
                            Icon(
                              Icons.search_outlined,
                              color: kSecBlue,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    CircleAvatar(
                      backgroundImage: userData!.data.image == ""
                          ? AssetImage("assets/images/profile.png")
                          : AssetImage(userData!.data.image),
                      backgroundColor: kSecBlue.withOpacity(0.4),
                      radius: 29,
                    )
                  ],
                ),
              ),
              loadingMessages == null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                        color: kSecBlue,
                        size: 50,
                      )),
                    )
                  : userData!.data.friends.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: EmptyWidget(
                            hideBackgroundAnimation: true,
                            image: null,
                            packageImage: PackageImage.Image_1,
                            title: 'No Chat History',
                            subTitle: 'Start Chatting',
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
                      : Expanded(
                          child: SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            controller: _refreshController,
                            onRefresh: _onRefresh,
                            child: ListView.builder(
                              itemCount: chatsData.length,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  ChatCard(
                                      chat: chatsData[index],
                                      press: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MessagesScreen(
                                                      chatsData:
                                                          chatsData[index],
                                                      messagesData:
                                                          messagesData[index],
                                                      userData: userData!)),
                                        ).then((value) => {
                                              setState(() {
                                                loadingMessages = null;
                                                _get();
                                              })
                                            });
                                      }),
                                  Opacity(
                                    opacity: 0.5,
                                    child: Divider(color: kSecBlue),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
            ],
          );
  }
}
