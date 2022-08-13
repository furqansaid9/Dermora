import 'dart:convert';
// import 'package:mongo_dart/mongo_dart.dart';

LoginResponseModel loginResponseModel(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.user,
    required this.token,
  });
  late final User user;
  late final String token;

  Data.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user.toJson();
    _data['token'] = token;
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.email,
    required this.isFirst,
    required this.fullName,
    required this.password,
    required this.image,
    required this.age,
    required this.sex,
    required this.phone,
    required this.kind,
    required this.address,
    required this.doctorInfo,
    required this.userInfo,
    required this.friends,
    required this.friendRequests,
    required this.sentRequests,
    required this.v,
  });
  late final String id;
  late final String email;
  late final bool isFirst;
  late final String fullName;
  late final String password;
  late final int age;
  late final String sex;
  late final String image;
  late final Address address;
  late final String kind;
  late final UserInfo userInfo;
  late final List<dynamic> friends;
  late final List<dynamic> friendRequests;
  late final List<dynamic> sentRequests;
  late final String phone;
  late final DoctorInfo doctorInfo;
  late final int v;

  User.fromJson(Map<String, dynamic> json) {
    // print(json);
    // print("from here");
    email = json['email'];
    id = json['_id'];
    isFirst = json['isFirst'];
    fullName = json['fullName'];
    password = json['password'];
    age = json['age'];
    sex = json['sex'];
    image = json['image'];
    address = Address.fromJson(json['address']);
    kind = json['kind'];
    userInfo = UserInfo.fromJson(json['userInfo']);
    friends = List.castFrom<dynamic, dynamic>(json['friends']);
    friendRequests = List.castFrom<dynamic, dynamic>(json['friendRequests']);
    sentRequests = List.castFrom<dynamic, dynamic>(json['sentRequests']);
    phone = json['phone'];
    doctorInfo = DoctorInfo.fromJson(json['doctorInfo']);
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['_id'] = id;
    _data['isFirst'] = isFirst;
    _data['fullName'] = fullName;
    _data['password'] = password;
    _data['age'] = age;
    _data['sex'] = sex;
    _data['image'] = image;
    _data['address'] = address.toJson();
    _data['kind'] = kind;
    _data['userInfo'] = userInfo.toJson();
    _data['friends'] = friends;
    _data['friendRequests'] = friendRequests;
    _data['sentRequests'] = sentRequests;
    _data['phone'] = phone;
    _data['doctorInfo'] = doctorInfo.toJson();
    _data['__v'] = v;

    return _data;
  }
}

class Address {
  Address({
    required this.country,
    required this.city,
    required this.street,
    required this.postCode,
  });
  late final String country;
  late final String city;
  late final String street;
  late final int postCode;

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
    street = json['street'];
    postCode = json['postCode'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['country'] = country;
    _data['city'] = city;
    _data['street'] = street;
    _data['postCode'] = postCode;
    return _data;
  }
}

class UserInfo {
  UserInfo({
    required this.skinType,
    required this.skinConcerns,
  });
  late final String skinType;
  late final List<String> skinConcerns;

  UserInfo.fromJson(Map<String, dynamic> json) {
    skinType = json['skinType'];
    skinConcerns = List.castFrom<dynamic, String>(json['skinConcerns']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['skinType'] = skinType;
    _data['skinConcerns'] = skinConcerns;
    return _data;
  }
}

class DoctorInfo {
  DoctorInfo();

  DoctorInfo.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}
