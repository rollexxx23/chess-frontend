import 'dart:convert';

import 'package:chess_game/models/game/game_state.dart';
import 'package:http/http.dart' as http;

class GetMoves {
  String baseUrl = "https://www.chessdb.cn/cdb.php?action=querypv&board=";
  getMove(String fen, int player) async {
    String url = "$baseUrl$fen";
    try {
      var data = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );

      // #### OUTPUT ####
      print(data.body);
      print(data.body[5] + data.body[6]);
      return {
        "from": data.body[5] + data.body[6],
        "to": data.body[7] + data.body[8],
        "promotion": "q"
      };
    } catch (e) {
      print("ERROR $e");
    }
  }
}
