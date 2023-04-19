import 'package:chess/chess.dart' as ch;
import 'package:chess_game/models/game/game_state.dart';

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

String? getRandomMove(String? fen) {
  final chess = ch.Chess.fromFEN(fen);

  final moves = chess.moves();

  if (moves.isEmpty) {
    return null;
  }

  moves.shuffle();

  return moves.first;
}
