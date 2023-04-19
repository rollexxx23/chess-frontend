// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:chess_game/models/game/game_state.dart';
import 'package:chess_game/utils/chess_game.dart' show makeMove;
import 'package:flutter/material.dart';
import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart"
    show Chessboard;
import 'package:get/get.dart';

const List<String> outcomes = ["Draw", "White", "Black"];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1';
  String errMsg = "";
  int player = 0;
  int cur = -1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
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
                      Get.back();
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
                  player == 0 ? "White to move" : "Black to move",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff95BB4A),
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Chessboard(
              fen: _fen,
              size: size.width,
              onMove: (move) {
                final state = makeMove(
                    _fen,
                    {
                      'from': move.from,
                      'to': move.to,
                      'promotion': 'q',
                    },
                    0);
                print(state.fen);
                if (state.fen == "invalid") {
                  setState(() {
                    errMsg = "Invalid Move";
                  });
                } else if (state.outcome != -1) {
                  setState(() {
                    cur = state.outcome;
                  });
                } else {
                  setState(() {
                    _fen = state.fen;
                    errMsg = "";
                    player = 1 - player;
                  });
                }
              },
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                errMsg,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.w500),
              ),
            ),
            (cur != -1)
                ? Center(
                    child: Text(
                      "Game Ended With: ${outcomes[cur]} ${(cur) > 0 ? "win" : ""}",
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
    );
  }
}
