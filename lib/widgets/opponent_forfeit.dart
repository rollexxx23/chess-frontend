import 'package:chess_game/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> opponentForfeited(BuildContext context,
    [bool isOnline = false]) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text("Opponent Forfeited"),
        actions: [
          CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Yay")),
        ],
        content: const Text("You won the game"),
      );
    },
  );
}
