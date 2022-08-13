import 'dart:convert';

Profile convertProfileModel(String str) => Profile.fromJson(json.decode(str));

class Profile {
  Profile({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  Profile.fromJson(Map<String, dynamic> json) {
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
    required this.address,
    required this.doctorInfo,
    required this.userInfo,
    required this.id,
    required this.email,
    required this.fullName,
    required this.password,
    required this.age,
    required this.sex,
    required this.image,
    required this.kind,
    required this.friends,
    required this.friendRequests,
    required this.sentRequests,
    required this.v,
    required this.phone,
  });
  late final Address address;
  late final DoctorInfo doctorInfo;
  late final UserInfo userInfo;
  late final String id;
  late final String email;
  late final String fullName;
  late final String password;
  late final int age;
  late final String sex;
  late final String image;
  late final String kind;
  late final List<Friends> friends;
  late final List<FriendsRequests> friendRequests;
  late final List<SentRequests> sentRequests;
  late final int v;
  late final String phone;

  Data.fromJson(Map<String, dynamic> json) {
    address = Address.fromJson(json['address']);
    doctorInfo = DoctorInfo.fromJson(json['doctorInfo']);
    userInfo = UserInfo.fromJson(json['userInfo']);
    id = json['_id'];
    email = json['email'];
    fullName = json['fullName'];
    password = json['password'];
    age = json['age'];
    sex = json['sex'];
    image = json['image'];
    kind = json['kind'];
    friends =
        List.from(json['friends']).map((e) => Friends.fromJson(e)).toList();
    friendRequests = List.from(json['friendRequests'])
        .map((e) => FriendsRequests.fromJson(e))
        .toList();
    sentRequests = List.from(json['sentRequests'])
        .map((e) => SentRequests.fromJson(e))
        .toList();
    v = json['__v'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address'] = address.toJson();
    _data['doctorInfo'] = doctorInfo.toJson();
    _data['userInfo'] = userInfo.toJson();
    _data['_id'] = id;
    _data['email'] = email;
    _data['fullName'] = fullName;
    _data['password'] = password;
    _data['age'] = age;
    _data['sex'] = sex;
    _data['image'] = image;
    _data['kind'] = kind;
    _data['friends'] = friends.map((e) => e.toJson()).toList();
    _data['friendsRequests'] = friendRequests.map((e) => e.toJson()).toList();
    _data['sentRequests'] = sentRequests.map((e) => e.toJson()).toList();

    _data['__v'] = v;
    _data['phone'] = phone;
    return _data;
  }
}

class Friends {
  Friends({
    required this.name,
    required this.id,
    required this.chatId,
    required this.image,
    required this.status,
  });
  late final String name;
  late final String id;
  late final String chatId;
  late final String image;
  late final bool status;

  Friends.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    chatId = json['chatId'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    _data['chatId'] = chatId;
    _data['image'] = image;
    _data['status'] = status;

    return _data;
  }
}

class FriendsRequests {
  FriendsRequests({
    required this.name,
    required this.id,
    required this.time,
    required this.image,
    required this.age,
    required this.city,
  });
  late final String name;
  late final String id;
  late final String time;
  late final String image;
  late final String city;
  late final int age;

  FriendsRequests.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    time = json['time'];
    image = json['image'];
    city = json['city'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    _data['time'] = time;
    _data['image'] = image;
    _data['age'] = age;
    _data['city'] = city;

    return _data;
  }
}

class SentRequests {
  SentRequests({
    required this.userId,
    required this.id,
  });
  late final String userId;
  late final String id;
  SentRequests.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = userId;
    _data['id'] = id;
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

class DoctorInfo {
  DoctorInfo({
    required this.workDetails,
    required this.isAvailable,
    required this.patients,
    required this.requests,
  });
  late final WorkDetails workDetails;
  late final bool isAvailable;
  late final List<dynamic> patients;
  late final List<dynamic> requests;

  DoctorInfo.fromJson(Map<String, dynamic> json) {
    workDetails = WorkDetails.fromJson(json['workDetails']);
    isAvailable = json['isAvailable'];
    patients = List.castFrom<dynamic, dynamic>(json['patients']);
    requests = List.castFrom<dynamic, dynamic>(json['requests']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['workDetails'] = workDetails.toJson();
    _data['isAvailable'] = isAvailable;
    _data['patients'] = patients;
    _data['requests'] = requests;
    return _data;
  }
}

class WorkDetails {
  WorkDetails();

  WorkDetails.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}

class UserInfo {
  UserInfo({
    required this.skinType,
    required this.skinConcerns,
    required this.doctors,
  });
  late final String skinType;
  late final List<String> skinConcerns;
  late final List<dynamic> doctors;

  UserInfo.fromJson(Map<String, dynamic> json) {
    skinType = json['skinType'];
    skinConcerns = List.castFrom<dynamic, String>(json['skinConcerns']);
    // doctors = List.castFrom<dynamic, dynamic>(json['doctors']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['skinType'] = skinType;
    _data['skinConcerns'] = skinConcerns;
    _data['doctors'] = doctors;
    return _data;
  }
}
