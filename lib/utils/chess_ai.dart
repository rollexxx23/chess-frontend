// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:chess/chess.dart' as ch;
import 'package:chess_game/models/game/chess_move_value.dart';

ch.Move minimaxRoot(int depth, String fen, bool isMaximisingPlayer) {
  final game = ch.Chess.fromFEN(fen);

  final moves = game.moves();
  num bestMove = -9999;
  var bestMoveFound;

  for (dynamic move in moves) {
    game.move(move);
    var value = minimax(depth - 1, game, -10000, 10000, !isMaximisingPlayer);
    game.undo_move();
    game.undo();
    if (value >= bestMove) {
      bestMove = value;
      bestMoveFound = move;
    }
  }
  return bestMoveFound;
}

num minimax(
    int depth, ch.Chess game, num alpha, num beta, bool isMaximisingPlayer) {
  if (depth == 0) {
    return (-1) * evaluateBoard(game);
  }

  final moves = game.moves();

  if (isMaximisingPlayer) {
    num bestMove = -9999;
    for (dynamic move in moves) {
      game.move(move);
      bestMove = max(
          bestMove, minimax(depth - 1, game, alpha, beta, !isMaximisingPlayer));
      game.undo_move();
      alpha = max(alpha, bestMove);
      if (beta <= alpha) {
        return bestMove;
      }
    }
    return bestMove;
  } else {
    num bestMove = 9999;
    for (dynamic move in moves) {
      game.move(move);
      bestMove = min(
          bestMove, minimax(depth - 1, game, alpha, beta, !isMaximisingPlayer));
      game.undo_move();
      beta = min(beta, bestMove);
      if (beta <= alpha) {
        return bestMove;
      }
    }
    return bestMove;
  }
}

num evaluateBoard(ch.Chess game) {
  num totalEvaluation = 0;
  for (int i = 0; i <= 119; i++) {
    totalEvaluation += getPieceValue(game.board[i], i);
  }
  return totalEvaluation;
}

List<List<double>> pawnEvalWhite = [
  [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
  [5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0],
  [1.0, 1.0, 2.0, 3.0, 3.0, 2.0, 1.0, 1.0],
  [0.5, 0.5, 1.0, 2.5, 2.5, 1.0, 0.5, 0.5],
  [0.0, 0.0, 0.0, 2.0, 2.0, 0.0, 0.0, 0.0],
  [0.5, -0.5, -1.0, 0.0, 0.0, -1.0, -0.5, 0.5],
  [0.5, 1.0, 1.0, -2.0, -2.0, 1.0, 1.0, 0.5],
  [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
];

List<List<double>> pawnEvalBlack = (pawnEvalWhite);

List<List<double>> knightEval = [
  [-5.0, -4.0, -3.0, -3.0, -3.0, -3.0, -4.0, -5.0],
  [-4.0, -2.0, 0.0, 0.0, 0.0, 0.0, -2.0, -4.0],
  [-3.0, 0.0, 1.0, 1.5, 1.5, 1.0, 0.0, -3.0],
  [-3.0, 0.5, 1.5, 2.0, 2.0, 1.5, 0.5, -3.0],
  [-3.0, 0.0, 1.5, 2.0, 2.0, 1.5, 0.0, -3.0],
  [-3.0, 0.5, 1.0, 1.5, 1.5, 1.0, 0.5, -3.0],
  [-4.0, -2.0, 0.0, 0.5, 0.5, 0.0, -2.0, -4.0],
  [-5.0, -4.0, -3.0, -3.0, -3.0, -3.0, -4.0, -5.0]
];

List<List<double>> bishopEvalWhite = [
  [-2.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -2.0],
  [-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0],
  [-1.0, 0.0, 0.5, 1.0, 1.0, 0.5, 0.0, -1.0],
  [-1.0, 0.5, 0.5, 1.0, 1.0, 0.5, 0.5, -1.0],
  [-1.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.0, -1.0],
  [-1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, -1.0],
  [-1.0, 0.5, 0.0, 0.0, 0.0, 0.0, 0.5, -1.0],
  [-2.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -2.0]
];

List<List<double>> bishopEvalBlack = (bishopEvalWhite);

List<List<double>> rookEvalWhite = [
  [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
  [0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5],
  [-0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.5],
  [-0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.5],
  [-0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.5],
  [-0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.5],
  [-0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.5],
  [0.0, 0.0, 0.0, 0.5, 0.5, 0.0, 0.0, 0.0]
];

List<List<double>> rookEvalBlack = (rookEvalWhite);

List<List<double>> evalQueen = [
  [-2.0, -1.0, -1.0, -0.5, -0.5, -1.0, -1.0, -2.0],
  [-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0],
  [-1.0, 0.0, 0.5, 0.5, 0.5, 0.5, 0.0, -1.0],
  [-0.5, 0.0, 0.5, 0.5, 0.5, 0.5, 0.0, -0.5],
  [0.0, 0.0, 0.5, 0.5, 0.5, 0.5, 0.0, -0.5],
  [-1.0, 0.5, 0.5, 0.5, 0.5, 0.5, 0.0, -1.0],
  [-1.0, 0.0, 0.5, 0.0, 0.0, 0.0, 0.0, -1.0],
  [-2.0, -1.0, -1.0, -0.5, -0.5, -1.0, -1.0, -2.0]
];

List<List<double>> kingEvalWhite = [
  [-3.0, -4.0, -4.0, -5.0, -5.0, -4.0, -4.0, -3.0],
  [-3.0, -4.0, -4.0, -5.0, -5.0, -4.0, -4.0, -3.0],
  [-3.0, -4.0, -4.0, -5.0, -5.0, -4.0, -4.0, -3.0],
  [-3.0, -4.0, -4.0, -5.0, -5.0, -4.0, -4.0, -3.0],
  [-2.0, -3.0, -3.0, -4.0, -4.0, -3.0, -3.0, -2.0],
  [-1.0, -2.0, -2.0, -2.0, -2.0, -2.0, -2.0, -1.0],
  [2.0, 2.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0],
  [2.0, 3.0, 1.0, 0.0, 0.0, 1.0, 3.0, 2.0]
];

List<List<double>> kingEvalBlack = (kingEvalWhite);

num getPieceValue(ch.Piece piece, int x) {
  if (piece.type == null) {
    return 0;
  }

  var absoluteValue = getAbsoluteValue(piece, piece.color.toString() == 'w', x);
  return piece.color.toString() == 'w' ? absoluteValue : (-1) * absoluteValue;
}

num getAbsoluteValue(ch.Piece piece, bool isWhite, int a) {
  if (SQUARES[a] == null) return 0;
  int x = SQUARES[a]![0];
  int y = SQUARES[a]![0];
  if (piece.type.toString() == 'p') {
    return 10 + (isWhite ? pawnEvalWhite[y][x] : pawnEvalBlack[y][x]);
  } else if (piece.type.name == 'r') {
    return 50 + (isWhite ? rookEvalWhite[y][x] : rookEvalBlack[y][x]);
  } else if (piece.type.name == 'n') {
    return 30 + knightEval[y][x];
  } else if (piece.type.name == 'b') {
    return 30 + (isWhite ? bishopEvalWhite[y][x] : bishopEvalBlack[y][x]);
  } else if (piece.type.name == 'q') {
    return 90 + evalQueen[y][x];
  } else if (piece.type.name == 'k') {
    return 900 + (isWhite ? kingEvalWhite[y][x] : kingEvalBlack[y][x]);
  }
  throw "Unknown piece type: ${piece.type.name}";
}

const Map<int, List<int>> SQUARES = {
  0: [0, 7],
  1: [1, 7],
  2: [2, 7],
  3: [3, 7],
  4: [4, 7],
  5: [5, 7],
  6: [6, 7],
  7: [7, 7],
  16: [0, 6],
  17: [1, 6],
  18: [2, 6],
  19: [3, 6],
  20: [4, 6],
  21: [5, 6],
  22: [6, 6],
  23: [7, 6],
  32: [0, 5],
  33: [1, 5],
  34: [2, 5],
  35: [3, 5],
  36: [4, 5],
  37: [5, 5],
  38: [6, 5],
  39: [7, 5],
  48: [0, 4],
  49: [1, 4],
  50: [2, 4],
  51: [3, 4],
  52: [4, 4],
  53: [5, 4],
  54: [6, 4],
  55: [7, 4],
  64: [0, 3],
  65: [1, 3],
  66: [2, 3],
  67: [3, 3],
  68: [4, 3],
  69: [5, 3],
  70: [6, 3],
  71: [7, 3],
  80: [0, 2],
  81: [1, 2],
  82: [2, 2],
  83: [3, 2],
  84: [4, 2],
  85: [5, 2],
  86: [6, 2],
  87: [7, 2],
  96: [0, 1],
  97: [1, 1],
  98: [2, 1],
  99: [3, 1],
  100: [4, 1],
  101: [5, 1],
  102: [6, 1],
  103: [7, 1],
  112: [0, 0],
  113: [1, 0],
  114: [2, 0],
  115: [3, 0],
  116: [4, 0],
  117: [5, 0],
  118: [6, 0],
  119: [7, 0],
};
