// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:chess_game/utils/chess_game.dart' show makeAiMove, makeMove;
import 'package:flutter/material.dart';
import "package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart"
    show Chessboard;
import 'package:flutter_stateless_chessboard/utils.dart';
import 'package:get/get.dart';

const List<String> outcomes = ["Draw", "White", "Black"];

class AiModeScreen extends StatefulWidget {
  @override
  _AiModeScreenState createState() => _AiModeScreenState();
}

class _AiModeScreenState extends State<AiModeScreen> {
  String? _fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1';
  String errMsg = "";
  int player = 0;
  int cur = -1;
  List<Widget> blackOccupied = [];
  List<Widget> whiteOccupied = [];
  @override
  void initState() {
    _fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1';
    errMsg = "";
    player = 0;
    cur = -1;
    // TODO: implement initState
    super.initState();
  }

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
                  if (cur != -1) {
                    return;
                  }
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
                    return;
                  } else if (state.outcome != -1) {
                    setState(() {
                      cur = state.outcome;
                      _fen = state.fen;
                      errMsg = "";
                      player = 1 - player;
                    });
                    return;
                  } else {
                    getOccupiedPieces(_fen, move);
                    setState(() {
                      _fen = state.fen;
                      errMsg = "";
                      player = 1 - player;
                    });
                  }

                  if (cur == -1) {
                    Future.delayed(const Duration(milliseconds: 300)).then((_) {
                      final state = makeAiMove(_fen ?? "", player);
                      if (state.fen == "invalid") {
                        setState(() {
                          errMsg = "Invalid Move";
                        });
                      } else if (state.outcome != -1) {
                        setState(() {
                          cur = state.outcome;
                          _fen = state.fen;
                          errMsg = "";
                          player = 1 - player;
                        });
                      } else {
                        print(state.lastMove);
                        getOccupiedPieces(_fen, state.lastMove, true);
                        setState(() {
                          _fen = state.fen;
                          errMsg = "";
                          player = 1 - player;
                        });
                      }
                    });
                  }
                }),
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
                        children: whiteOccupied,
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
                        children: blackOccupied,
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

  void getOccupiedPieces(String? fen, dynamic move, [bool ai = false]) {
    final mp = getPieceMap(fen);
    String p = (ai == false)
        ? mp[move.to].toString()
        : mp[move[move.toString().length - 2] +
                move[move.toString().length - 1]]
            .toString();
    if (p != "null") {
      if (p[0] == 'b') {
        setState(() {
          blackOccupied.insert(
            blackOccupied.length,
            Image.asset("assets/pieces/$p.png", height: 30, width: 30),
          );
        });
      } else {
        setState(() {
          whiteOccupied.insert(whiteOccupied.length,
              Image.asset("assets/pieces/$p.png", height: 30, width: 30));
        });
      }
    }
  }
}
