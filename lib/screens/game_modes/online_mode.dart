// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:chess_game/models/game/online_game.dart';
import 'package:chess_game/utils/chess_game.dart' show makeMove;
import 'package:chess_game/utils/getx_controller.dart';
import 'package:chess_game/utils/occupied_pieces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart"
    show Chessboard;
import 'package:flutter_stateless_chessboard/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_stateless_chessboard/types.dart' as types;

import '../home/home.dart';

const List<String> outcomes = ["Draw", "White", "Black"];

class OnlineMode extends StatefulWidget {
  @override
  OnlineMode({super.key, required this.model});
  OnlineGameModel model;
  @override
  _OnlineModeState createState() => _OnlineModeState();
}

class _OnlineModeState extends State<OnlineMode> {
  // String? _fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1';
  final CurrentFenController controller = Get.put(CurrentFenController());
  String errMsg = "";

  @override
  void initState() {
    controller.updateCurrentFen(
        "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1");
    errMsg = "";
    controller.updatePlayer(0);
    controller.updateCur(-1);
    //listenForMoves();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Obx((() => SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          showForfeitOnline(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.model.whiteUser} v/s ${widget.model.blackUser}",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff95BB4A),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      controller.player == 0
                          ? "White to move"
                          : "Black to move",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xff95BB4A),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Chessboard(
                  orientation: (widget.model.isWhite)
                      ? types.Color.WHITE
                      : types.Color.BLACK,
                  fen: controller.fen,
                  size: size.width,
                  onMove: (move) {
                    if (controller.cur != -1) {
                      return;
                    }

                    final state = makeMove(
                        controller.fen,
                        {
                          'from': move.from,
                          'to': move.to,
                          'promotion': 'q',
                        },
                        0);
                    print(state.fen);
                    if (!isValidMove(controller.fen, move) ||
                        state.fen == "invalid") {
                      setState(() {
                        errMsg = (state.fen == "invalid")
                            ? "Invalid Move"
                            : "Not Your Move";
                      });
                    } else if (state.outcome != -1) {
                      // send move
                      sendMoves(move);
                      setState(() {
                        controller.updateCur(state.outcome);
                        controller.updateCurrentFen(state.fen ?? "");
                        errMsg = "";
                        controller.alterPlayer();
                      });
                    } else {
                      // send move
                      sendMoves(move);
                      OccupiedPieces.getOccupiedPieces(controller.fen, move);
                      setState(() {
                        controller.updateCurrentFen(state.fen ?? "");
                        errMsg = "";
                        controller.alterPlayer();
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.black,
                  height: 50,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: controller.getWhite,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 50,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: controller.getBlack,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    errMsg,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                (controller.cur != -1)
                    ? Center(
                        child: Text(
                          "Game Ended With: ${outcomes[controller.cur]} ${(controller.cur) > 0 ? "win" : ""}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        )));
  }

  bool isValidMove(String? fen, dynamic move) {
    final mp = getPieceMap(fen);
    String p = mp[move.from].toString();

    if (p[0] == 'b') {
      return widget.model.isWhite == false;
    }
    return widget.model.isWhite == true;
  }

  void sendMoves(var move) {
    var bodyData = {
      "email": widget.model.myEmail,
      "token": "1224",
      "game_id": widget.model.id,
      "src": move.from,
      "des": move.to,
      "prom": ""
    };

    String msg = json.encode(bodyData).toString();
    print(msg);
    widget.model.channel.sink.add(msg);
  }

  void sendForfeit() {
    var bodyData = {
      "email": widget.model.myEmail,
      "token": "1224",
      "game_id": widget.model.id,
      "src": "",
      "des": "",
      "prom": ""
    };

    String msg = json.encode(bodyData).toString();
    print(msg);
    widget.model.channel.sink.add(msg);
    widget.model.channel.sink.close();
  }

  Future<void> showForfeitOnline(BuildContext context,
      [bool isOnline = false]) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Forfeit?"),
          actions: [
            CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Back")),
            CupertinoDialogAction(
                onPressed: () {
                  sendForfeit();
                  Get.offAll(const HomeScreen());
                },
                child: const Text("Yes")),
          ],
          content: const Text("You will lose the game"),
        );
      },
    );
  }
}
