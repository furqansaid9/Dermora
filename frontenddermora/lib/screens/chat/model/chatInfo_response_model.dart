import 'dart:convert';

ChatInfo chaInfoConverter(String str) => ChatInfo.fromJson(json.decode(str));

class ChatInfo {
  ChatInfo({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  ChatInfo.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.users,
    required this.v,
    required this.endTime,
    required this.isStarted,
    required this.isClosed,
    required this.startTime,
  });
  late final String id;
  late final List<String> users;
  late final int v;
  late final String endTime;
  late final bool isStarted;
  late final bool isClosed;
  late final String startTime;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    users = List.castFrom<dynamic, String>(json['users']);
    v = json['__v'];
    endTime = json['endTime'];
    isStarted = json['isStarted'];
    isClosed = json['isClosed'];
    startTime = json['startTime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['users'] = users;
    _data['__v'] = v;
    _data['endTime'] = endTime;
    _data['isStarted'] = isStarted;
    _data['isClosed'] = isClosed;
    _data['startTime'] = startTime;
    return _data;
  }
}
