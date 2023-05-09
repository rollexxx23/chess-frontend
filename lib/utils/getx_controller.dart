import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentFenController extends GetxController {
  RxString _fen = "".obs;
  RxInt _player = 0.obs;
  RxInt _cur = (-1).obs;
  var blackOccupied = <Widget>[].obs;
  var whiteOccupied = <Widget>[].obs;

  String get fen => _fen.value;
  int get player => _player.value;
  int get cur => _cur.value;
  List<Widget> get getWhite => whiteOccupied;
  List<Widget> get getBlack => blackOccupied;
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

  clearPieces() {
    blackOccupied.value = [];
    whiteOccupied.value = [];
    update();
  }

  addBlackPieces(String p) {
    blackOccupied.insert(
      blackOccupied.length,
      Image.asset("assets/pieces/$p.png", height: 30, width: 30),
    );
  }

  addWhitePieces(String p) {
    whiteOccupied.insert(
      whiteOccupied.length,
      Image.asset("assets/pieces/$p.png", height: 30, width: 30),
    );
  }
}
