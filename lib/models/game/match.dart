class MatchModel {
  String whitePlayerUserName;
  String blackPlayerUserName;
  String whitePlayer;
  String blackPlayer;
  String gameMoves;
  int moves;
  int result;
  String comment;

  MatchModel(
      {required this.blackPlayer,
      required this.blackPlayerUserName,
      required this.comment,
      required this.gameMoves,
      required this.moves,
      required this.result,
      required this.whitePlayer,
      required this.whitePlayerUserName});
}
