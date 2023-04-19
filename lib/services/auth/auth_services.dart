import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chess_game/models/auth/user_login.dart';
import 'package:chess_game/models/auth/user_reg.dart';

class AuthServices {
  static loginUser(UserLoginModel model) async {
    String url = "http://10.0.2.2:5000/login";
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
        print("LOGIN SUCCESSFUL");
      }
    } catch (e) {
      print("ERROR $e");
    }
  }

  static registerUser(UserRegisterModel model) async {
    String url = "http://10.0.2.2:5000/register";
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
