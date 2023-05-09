import 'package:chess_game/utils/getx_controller.dart';
import 'package:flutter_stateless_chessboard/utils.dart';
import 'package:get/get.dart';

class OccupiedPieces {
  static CurrentFenController controller = Get.put(CurrentFenController());
  static void getOccupiedPieces(String? fen, dynamic move) {
    final mp = getPieceMap(fen);
    String p = mp[move.to].toString();
    if (p != "null") {
      if (p[0] == 'b') {
        controller.addBlackPieces(p);
      } else {
        controller.addWhitePieces(p);
      }
    }
  }
}
