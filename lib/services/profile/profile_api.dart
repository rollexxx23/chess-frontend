import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chess_game/models/auth/profile.dart';
import 'package:flutter/foundation.dart';

class ProfileAPI {
  String baseURL =
      (kIsWeb) ? "http://localhost:5000/" : "http://10.0.2.2:5000/";
  Future<ProfileModel?> getProfileDetails(String email) async {
    String url = "${baseURL}users/$email";
    try {
      var data = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );

      // #### OUTPUT ####
      print(data.body);
      var jsonDecoded = await json.decode(data.body);
      return ProfileModel(
          country: jsonDecoded["country"] ?? "",
          drawCnt: jsonDecoded["draw_cnt"] ?? 0,
          email: jsonDecoded["email"] ?? "",
          lossCnt: jsonDecoded["loss_cnt"] ?? 0,
          username: jsonDecoded["username"] ?? "",
          winCnt: jsonDecoded["win_cnt"] ?? 0);
    } catch (e) {
      print("ERROR $e");
    }
  }
}
