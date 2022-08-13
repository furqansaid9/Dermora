class ChatRequestModel {
  ChatRequestModel({
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.doctorId,
    required this.doctorName,
    required this.doctorImage,
  });
  late final String userId;
  late final String userName;
  late final String userImage;
  late final String doctorId;
  late final String doctorName;
  late final String doctorImage;

  ChatRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
    doctorId = json['doctorId'];
    doctorName = json['doctorName'];
    doctorImage = json['doctorImage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['userName'] = userName;
    _data['userImage'] = userImage;
    _data['doctorId'] = doctorId;
    _data['doctorName'] = doctorName;
    _data['doctorImage'] = doctorImage;
    return _data;
  }
}
