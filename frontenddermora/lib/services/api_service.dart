import 'dart:convert';

import 'package:frontenddermora/screens/auth/models/login_request_model.dart';
import 'package:frontenddermora/screens/auth/models/login_response_model.dart';
import 'package:frontenddermora/screens/auth/models/register_response_model.dart';
import 'package:frontenddermora/services/shared_service.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../screens/auth/models/Profile_model.dart';
import '../screens/auth/models/register_request_model.dart';
import '../screens/primary_questions/models/concerns.dart';

class APIService {
  static var client = http.Client();

  static Future<LoginResponseModel?> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.loginAPI);
    var response = await client.post(
      url,
      // headers: requestHeaders,
      body: (model.toJson()),
    );
    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseModel(response.body));
      return loginResponseModel(response.body);
    } else {
      return null;
    }
  }

  static Future<bool> register(RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.registerAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      //shared
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getArticles() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'basic ${loginDetails!.data.token}',
    };
    var url = Uri.http(Config.apiURL, Config.articlesAPI);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      //shared
      return response.body;
    } else {
      return "";
    }
  }

  static Future<Profile?> getUserData() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'basic ${loginDetails!.data.token}',
    };
    var url = Uri.http(Config.apiURL, '/user/${loginDetails.data.user.id}');
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return convertProfileModel(response.body);
    } else {
      return null;
    }
  }

  static Future<bool> updateIsFirst() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'basic ${loginDetails!.data.token}',
    };

    var url = Uri.http(
        Config.apiURL, "user/updateIsFirst/${loginDetails.data.user.id}");
    var response = await client.post(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateAgeSex(age, sex) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'basic ${loginDetails!.data.token}',
    };
    var data = {"age": age, "sex": sex, "id": loginDetails.data.user.id};

    var url = Uri.http(Config.apiURL, "user/updateAgeSex/");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateSkinType(type) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'basic ${loginDetails!.data.token}',
    };
    var data = {"skin": type, "id": loginDetails.data.user.id};

    var url = Uri.http(Config.apiURL, "user/updateSkin/");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateConcerns(List<Concern> concerns) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'basic ${loginDetails!.data.token}',
    };
    String json =
        jsonEncode(concerns.map((i) => i.toJson()).toList()).toString();

    var url = Uri.http(Config.apiURL, "user/updateConcerns/");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "concerns": concerns.map((i) => i.toJson()).toList(),
        "id": loginDetails.data.user.id
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
