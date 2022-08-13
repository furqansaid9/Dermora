import 'dart:convert';

RoutineResponseModel routineResponseConverter(String str) =>
    RoutineResponseModel.fromJson(json.decode(str));

class RoutineResponseModel {
  RoutineResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  RoutineResponseModel.fromJson(Map<String, dynamic> json) {
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
    required this.morningRoutine,
    required this.nightRoutine,
    required this.id,
    required this.user,
    required this.v,
  });
  late final MorningRoutine morningRoutine;
  late final NightRoutine nightRoutine;
  late final String id;
  late final String user;
  late final int v;

  Data.fromJson(Map<String, dynamic> json) {
    morningRoutine = MorningRoutine.fromJson(json['morningRoutine']);
    nightRoutine = NightRoutine.fromJson(json['nightRoutine']);
    id = json['_id'];
    user = json['user'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['morningRoutine'] = morningRoutine.toJson();
    _data['nightRoutine'] = nightRoutine.toJson();
    _data['_id'] = id;
    _data['user'] = user;
    _data['__v'] = v;
    return _data;
  }
}

class MorningRoutine {
  MorningRoutine({
    required this.time,
    required this.products,
  });
  late final String time;
  late final List<ListProducts> products;

  MorningRoutine.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    products = List.from(json['products'])
        .map((e) => ListProducts.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['time'] = time;
    _data['products'] = products.map((e) => e.toJson()).toList();
    return _data;
  }
}

class NightRoutine {
  NightRoutine({
    required this.time,
    required this.products,
  });
  late final String time;
  late final List<ListProducts> products;

  NightRoutine.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    products = List.from(json['products'])
        .map((e) => ListProducts.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['time'] = time;
    _data['products'] = products.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListProducts {
  ListProducts({
    required this.image,
    required this.label,
    required this.kind,
    required this.id,
  });
  late final String image;
  late final String label;
  late final String kind;
  late final String id;

  ListProducts.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    label = json['label'];
    kind = json['kind'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['label'] = label;
    _data['kind'] = kind;
    _data['_id'] = id;
    return _data;
  }
}
