class GameStateModel {
  String? fen;
  int outcome; // -1 -> ongoing, 0 -> draw, 1 -> white, 2 ->black
  GameStateModel({required this.fen, required this.outcome});
}
