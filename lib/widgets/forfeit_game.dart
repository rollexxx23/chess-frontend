import 'package:chess_game/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showForfeit(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text("Forfeit?"),
        actions: [
          CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Back")),
          CupertinoDialogAction(
              onPressed: () {
                Get.offAll(const HomeScreen());
              },
              child: const Text("Yes")),
        ],
        content: const Text("You will lose the game"),
      );
    },
  );
}
