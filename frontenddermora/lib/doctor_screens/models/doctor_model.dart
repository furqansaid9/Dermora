import 'dart:convert';

DoctorModel convertDoctorModel(String str) =>
    DoctorModel.fromJson(json.decode(str));

class DoctorModel {
  DoctorModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final List<Data> data;

  DoctorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.map((e) => e.toJson()).toList();
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
    required this.v,
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
  late final List<dynamic> friends;
  late final int v;

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
    friends = List.castFrom<dynamic, dynamic>(json['friends']);
    v = json['__v'];
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
    _data['friends'] = friends;
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

class DoctorInfo {
  DoctorInfo({
    required this.workDetails,
    required this.isAvailable,
    required this.noOfPatients,
    required this.patients,
    required this.requests,
  });
  late final WorkDetails workDetails;
  late final bool isAvailable;
  late final int noOfPatients;
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
    _data['noOfPatients'] = noOfPatients;
    _data['patients'] = patients;
    _data['requests'] = requests;
    return _data;
  }
}

class WorkDetails {
  WorkDetails({
    required this.clinicName,
    required this.address,
    required this.jobTitle,
    required this.experience,
  });
  late final String? clinicName;
  late final String? address;
  late final String? jobTitle;
  late final String? experience;

  WorkDetails.fromJson(Map<String, dynamic> json) {
    clinicName = json['clinicName'];
    address = json['address'];
    jobTitle = json['jobTitle'];
    experience = json['experience'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['clinicName'] = clinicName;
    _data['address'] = address;
    _data['jobTitle'] = jobTitle;
    _data['experience'] = experience;

    return _data;
  }
}

class UserInfo {
  UserInfo({
    required this.skinConcerns,
  });
  late final List<dynamic> skinConcerns;

  UserInfo.fromJson(Map<String, dynamic> json) {
    skinConcerns = List.castFrom<dynamic, dynamic>(json['skinConcerns']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['skinConcerns'] = skinConcerns;
    return _data;
  }
}
