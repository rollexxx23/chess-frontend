import 'dart:convert';
import 'package:chess_game/screens/home/home.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:chess_game/models/auth/user_login.dart';
import 'package:chess_game/models/auth/user_reg.dart';

String baseURL = (kIsWeb) ? "http://localhost:5000/" : "http://10.0.2.2:5000/";

class AuthServices {
  static loginUser(UserLoginModel model) async {
    String url = "${baseURL}login";
    var bodyData = {"email": model.email, "password": model.password};

    var body = json.encode(bodyData);
    print(body);
    try {
      var data = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      // #### OUTPUT ####
      var jsonDecoded = await json.decode(data.body);
      // print(jsonDecoded);
      if (jsonDecoded["message"] != null) {
        return jsonDecoded["message"];
      } else {
        saveCred(jsonDecoded);
        print("LOGIN SUCCESSFUL");
        Get.offAll(const HomeScreen());
      }
    } catch (e) {
      print("ERROR $e");
    }
  }

  static registerUser(UserRegisterModel model) async {
    String url = "${baseURL}register";
    var bodyData = {
      "email": model.email,
      "password": model.password,
      "username": model.username,
      "name": ""
    };

    var body = json.encode(bodyData);
    print(body);
    try {
      var data = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      // #### OUTPUT ####
      var jsonDecoded = await json.decode(data.body);
      print(jsonDecoded);
      if (jsonDecoded["message"] != null) {
        return jsonDecoded["message"];
      } else {
        print("LOGIN SUCCESSFUL");
      }
    } catch (e) {
      print("ERROR $e");
    }
  }
}

void saveCred(var json) {
  final storage = GetStorage();
  storage.write('loggedIn', true);
  print(json["access_token"]);
  storage.write('accessToken', json["access_token"]);
}
