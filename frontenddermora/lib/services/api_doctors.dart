import 'dart:convert';
import 'package:frontenddermora/services/shared_service.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../doctor_screens/models/doctor_model.dart';

class APIDoctors {
  static var client = http.Client();

  static Future<DoctorModel?> getAvailableDoctors() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'basic ${loginDetails!.data.token}',
    };

    var url = Uri.http(Config.apiURL, Config.availableDoctorsAPI);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      //shared'
      return convertDoctorModel(response.body);
    } else {
      return null;
    }
  }
}
