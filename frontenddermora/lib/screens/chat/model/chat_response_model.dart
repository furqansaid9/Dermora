import 'dart:convert';

ChatResponseModel ChatModelConverter(String str) =>
    ChatResponseModel.fromJson(json.decode(str));

class ChatResponseModel {
  ChatResponseModel({
    required this.messages,
    required this.friendData,
    required this.chatId,
    required this.chat,
  });
  late final List<Messages> messages;
  late final FriendData friendData;
  late final String chatId;
  late final Chats chat;

  ChatResponseModel.fromJson(Map<String, dynamic> json) {
    messages =
        List.from(json['messages']).map((e) => Messages.fromJson(e)).toList();
    friendData = FriendData.fromJson(json['friendData']);
    chat = Chats.fromJson(json['chats']);
    chatId = json['chatId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['messages'] = messages.map((e) => e.toJson()).toList();
    _data['friendData'] = friendData.toJson();
    _data['chats'] = chat.toJson();
    _data['chatId'] = chatId;
    return _data;
  }
}

class Messages {
  Messages({
    required this.id,
    required this.sender,
    required this.content,
    required this.timestamp,
    required this.v,
  });
  late final String id;
  late final String sender;
  late final String content;
  late final String timestamp;
  late final int v;

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    sender = json['sender'];
    content = json['content'];
    timestamp = json['timestamp'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['sender'] = sender;
    _data['content'] = content;
    _data['timestamp'] = timestamp;
    _data['__v'] = v;
    return _data;
  }
}

class Chats {
  Chats({
    required this.id,
    required this.users,
    required this.v,
    required this.endTime,
    required this.isStarted,
    required this.isClosed,
    required this.startTime,
  });
  late final String id;
  late final List<Users> users;
  late final int v;
  late final String? endTime;
  late final bool isStarted;
  late final bool isClosed;
  late final String? startTime;

  Chats.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    users = List.from(json['users']).map((e) => Users.fromJson(e)).toList();
    v = json['__v'];
    endTime = json['endTime'];
    isStarted = json['isStarted'];
    isClosed = json['isClosed'];
    startTime = json['startTime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['users'] = users.map((e) => e.toJson()).toList();
    _data['__v'] = v;
    _data['endTime'] = endTime;
    _data['isStarted'] = isStarted;
    _data['isClosed'] = isClosed;
    _data['startTime'] = startTime;
    return _data;
  }
}

class Users {
  Users({
    required this.id,
    required this.image,
  });
  late final String id;
  late final String image;

  Users.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['image'] = image;
    return _data;
  }
}

class FriendData {
  FriendData({
    required this.id,
    required this.image,
  });
  late final String id;
  late final String image;

  FriendData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['image'] = image;
    return _data;
  }
}
