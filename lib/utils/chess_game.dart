import 'dart:io';

import 'package:chess/chess.dart' as ch;
import 'package:chess_game/models/game/game_state.dart';
import 'package:chess_game/services/get_moves/best_move.dart';
import 'package:chess_game/utils/chess_ai.dart';

GameStateModel makeMove(String? fen, dynamic move, int player) {
  final chess = ch.Chess.fromFEN(fen);

  if (chess.move(move)) {
    if (chess.in_draw) {
      return GameStateModel(fen: chess.fen, outcome: 0);
    } else if (chess.in_checkmate) {
      return GameStateModel(fen: chess.fen, outcome: player + 1);
    }
    return GameStateModel(fen: chess.fen, outcome: -1);
  } else {
    return GameStateModel(fen: "invalid", outcome: -1);
  }
}

GameStateModel makeAiMove(String fen, int player) {
  var move = minimaxRoot(2, fen, true);

  sleep(const Duration(seconds: 1));
  GameStateModel res = makeMove(fen, move, player);
  res.lastMove = move;
  return res;
}

Future<GameStateModel> level2AI(String fen, int player) async {
  var move = await GetMoves().getMove(fen, player);
  print(move["from"]);
  sleep(const Duration(seconds: 1));
  GameStateModel res = makeMove(fen, move, player);
  res.lastMove = move;
  return res;
}
