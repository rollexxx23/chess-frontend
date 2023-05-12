import 'dart:convert';

import 'package:chess_game/models/game/game_state.dart';
import 'package:http/http.dart' as http;

class GetMoves {
  String baseUrl = "https://www.chessdb.cn/cdb.php?action=queryall&board=";
  getMove(String fen, int player, int dif) async {
    String url = "$baseUrl$fen&json=1";
    try {
      var data = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );

      // #### OUTPUT ####
      var jsonDecoded = await json.decode(data.body);
      print(jsonDecoded);
      if (jsonDecoded["status"] != "ok") return null;
      int idx = (dif == 3) ? 0 : jsonDecoded["moves"].length() - 1;
      return {
        "from": jsonDecoded["moves"][idx]["uci"][0] +
            jsonDecoded["moves"][idx]["uci"][1],
        "to": jsonDecoded["moves"][idx]["uci"][2] +
            jsonDecoded["moves"][idx]["uci"][3],
        "promotion": "q"
      };
    } catch (e) {
      print("ERROR $e");
    }
  }
}
