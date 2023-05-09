import 'package:get/get.dart';

class CurrentFenController extends GetxController {
  RxString _fen = "".obs;
  RxInt _player = 0.obs;
  RxInt _cur = (-1).obs;
  String get fen => _fen.value;
  int get player => _player.value;
  int get cur => _cur.value;

  updateCurrentFen(String value) {
    _fen.value = value;
    update();
  }

  updatePlayer(int value) {
    _player.value = value;
    update();
  }

  alterPlayer() {
    _player.value = 1 - _player.value;
    update();
  }

  updateCur(int value) {
    _cur.value = value;
    update();
  }
}
