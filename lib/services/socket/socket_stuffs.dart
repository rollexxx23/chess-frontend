import 'dart:convert';

import 'package:chess_game/models/game/online_game.dart';
import 'package:chess_game/screens/game_modes/online_mode.dart';
import 'package:chess_game/utils/chess_game.dart';
import 'package:chess_game/utils/getx_controller.dart';
import 'package:chess_game/utils/occupied_pieces.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart"
    show ShortMove;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketStuffs {
  late WebSocketChannel channel;
  late String email;
  static CurrentFenController controller = Get.put(CurrentFenController());
  SocketStuffs() {
    init();
    //sleep(const Duration(milliseconds: 10));
    readMessages();
  }

  init() async {
    try {
      channel = (kIsWeb)
          ? WebSocketChannel.connect(
              Uri.parse("ws://localhost:5000/lobby"),
            )
          : WebSocketChannel.connect(
              Uri.parse("ws://10.0.2.2:5000/lobby"),
            );

      final storage = GetStorage();
      email = storage.read('email') ?? "";

      sendMessage(
          "{\"message_type\":\"find_match\", \"token\":\"abc\", \"email\": \"$email\"}");
    } catch (e) {
      print(e);
    }
  }

  sendMessage(String text) {
    channel.sink.add(text);
  }

  void readMessages() async {
    channel.stream.listen((event) async {
      var jsonDecoded = await json.decode(event);
      if (jsonDecoded["message_type"] != null &&
          jsonDecoded["message_type"] == "GAME_INIT") {
        initGame(jsonDecoded);
        return;
      } else if (jsonDecoded["message_type"] != null &&
          jsonDecoded["message_type"] == "GAME_MOVE") {
        handleMoves(jsonDecoded);
      }
    });
  }

  void initGame(var jsonDecoded) {
    print("GAME INIT CALLED");
    EasyLoading.dismiss();
    OnlineGameModel model = OnlineGameModel(
        id: jsonDecoded["id"],
        channel: channel,
        myEmail: email,
        blackUser: jsonDecoded["black_username"],
        whiteUser: jsonDecoded["white_username"],
        isWhite: email == jsonDecoded["white_email"]);
    Get.to(OnlineMode(model: model));
  }

  void handleMoves(var jsonDecoded) {
    print("!!!!!!!!!!!!!!!!!!!!!!!");
    if (controller.cur != -1) {
      return;
    }
    print(jsonDecoded);
    final state = makeMove(
        controller.fen,
        {
          'from': jsonDecoded["src"],
          'to': jsonDecoded["des"],
          'promotion': 'q',
        },
        0);

    if (state.fen == "invalid") {
      print("invalid");
    } else if (state.outcome != -1) {
      // send move

      controller.updateCur(state.outcome);
      controller.updateCurrentFen(state.fen ?? "");

      controller.alterPlayer();
    } else {
      ShortMove move =
          ShortMove(from: jsonDecoded["src"], to: jsonDecoded["des"]);
      OccupiedPieces.getOccupiedPieces(controller.fen, move);
      controller.updateCurrentFen(state.fen ?? "");
      controller.alterPlayer();
    }
  }
}
