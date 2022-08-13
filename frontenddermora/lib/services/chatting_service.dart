import 'package:socket_io_client/socket_io_client.dart';
import '../config.dart';

import 'dart:convert';

import 'package:frontenddermora/services/shared_service.dart';
import 'package:http/http.dart' as http;

import '../screens/chat/model/chatInfo_response_model.dart';
import '../screens/chat/model/chat_response_model.dart';
import '../screens/messages/components/body.dart';
import '../screens/messages/models/messages.dart';

class APIChatService {
  static var client = http.Client();
  static Future<ChatInfo?> getChatInfo(chatId) async {
    print("#################3");
    print(chatId);
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'basic ${loginDetails!.data.token}',
    };

    var url = Uri.http(Config.apiURL, 'chatInfo/$chatId');
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return chaInfoConverter(response.body);
    } else {
      return null;
    }
  }

  static Future<ChatResponseModel?> getChat(chatId) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'basic ${loginDetails!.data.token}',
    };

    var url = Uri.http(Config.apiURL, 'chat/${chatId}');
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return ChatModelConverter(response.body);
    } else {
      return null;
    }
  }

  static Future<String> createChat(data) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'basic ${loginDetails!.data.token}',
    };

    var url = Uri.http(Config.apiURL, Config.createChatAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: data,
    );
    if (response.statusCode == 200) {
      //shared'
      return "success";
    } else {
      return "No";
    }
  }

  static Future<String> updateChat(chatId) async {
    print(chatId);
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'basic ${loginDetails!.data.token}',
    };

    var url = Uri.http(Config.apiURL, Config.updateChatAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: json.encode({"chatId": chatId}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return "success";
    } else {
      return "No";
    }
  }

  static Future<String> updateChatStatus(chatId) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'basic ${loginDetails!.data.token}',
    };

    var url = Uri.http(Config.apiURL, Config.updateChatStatusAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body:
          json.encode({"chatId": chatId, "userId": loginDetails.data.user.id}),
    );
    if (response.statusCode == 200) {
      return "success";
    } else {
      return "No";
    }
  }

  static dynamic sendBackData(data) {
    return data;
  }
}
