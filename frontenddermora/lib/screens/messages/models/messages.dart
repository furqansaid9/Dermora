import 'dart:convert';

import 'package:frontenddermora/screens/chat/model/chat_response_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String content;
  final String chatId;
  final String timeStamp;
  final String sender;
  final bool isSender;
  final String senderImage;
  final String friendId;

  ChatMessage({
    this.content = '',
    required this.chatId,
    required this.timeStamp,
    required this.sender,
    required this.isSender,
    required this.senderImage,
    required this.friendId,
  });
}

ServerMessage messageConverter(String str) =>
    ServerMessage.fromJson(json.decode(str));

class ServerMessage {
  ServerMessage({
    required this.content,
    required this.chatId,
    required this.timeStamp,
    required this.sender,
    required this.senderImage,
    required this.friendId,
  });
  late final String content;
  late final String chatId;
  late final String timeStamp;
  late final String sender;
  late final String senderImage;
  late final String friendId;

  ServerMessage.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    chatId = json['chatId'];
    timeStamp = json['timeStamp'];
    sender = json['sender'];
    senderImage = json['senderImage'];
    friendId = json['friendId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content;
    _data['chatId'] = chatId;
    _data['timeStamp'] = timeStamp;
    _data['sender'] = sender;
    _data['senderImage'] = senderImage;
    _data['friendId'] = friendId;
    return _data;
  }
}
