import 'dart:convert';

import 'package:frontenddermora/services/shared_service.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../screens/routine/models/products.dart';
import '../screens/routine/models/routine_response_model.dart';

class ProductsApi {
  static var client = http.Client();

  static const _api_key = "f952ec2bfcmsheaec78ad6ae78fdp15747ajsn9036bfc96962";
  static const String _baseUrl = "sephora.p.rapidapi.com";
  static const Map<String, String> _headers = {
    "content-type": "application/json",
    "X-RapidAPI-Host": "sephora.p.rapidapi.com",
    "X-RapidAPI-Key": "f952ec2bfcmsheaec78ad6ae78fdp15747ajsn9036bfc96962",
  };
  static Future<List<Products>> getProducts(String query) async {
    final queryParameters = {'q': query, 'pageSize': '60', 'currentPage': '1'};
    Uri uri = Uri.https(_baseUrl, "/products/search/", queryParameters);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      ProductsModel res = convertProducts(response.body);
      return res.products;
    } else {
      throw Exception();
    }
  }

  static Future<List<Products>> getAllProducts() async {
    final queryParameters = {
      'categoryId': "cat150006",
      'pageSize': '10',
      'currentPage': '1'
    };
    Uri uri = Uri.https(_baseUrl, "/products/list/", queryParameters);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      AllProductsModel res = convertAllProducts(response.body);
      return res.products;
    } else {
      throw Exception();
    }
  }

  static Future<RoutineResponseModel?> getRoutine() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'basic ${loginDetails!.data.token}',
    };

    var url = Uri.http(Config.apiURL, 'routine/${loginDetails.data.user.id}');
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return routineResponseConverter(response.body);
    } else {
      return null;
    }
  }

  static Future<String> addProductToRoutine(data, time) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'basic ${loginDetails!.data.token}',
    };
    var url = Uri.http(Config.apiURL, 'addProduct');
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: json.encode(
          {"data": data, "userId": loginDetails.data.user.id, "time": time}),
    );
    if (response.statusCode == 200) {
      return "success";
    } else {
      return "no";
    }
  }
}
