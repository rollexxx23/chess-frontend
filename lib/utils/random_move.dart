import 'package:chess/chess.dart' as ch;

ch.Move? getRandomMove(String fen) {
  final chess = ch.Chess.fromFEN(fen);

  final moves = chess.moves();

  if (moves.isEmpty) {
    return null;
  }

  moves.shuffle();

  return moves.first;
}
