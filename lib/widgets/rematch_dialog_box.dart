import 'package:chess_game/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showRematch(BuildContext context, var fun) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text("Rematch?"),
        actions: [
          CupertinoDialogAction(
              onPressed: () {
                Get.offAll(const HomeScreen());
              },
              child: const Text("Exit")),
          CupertinoDialogAction(
              onPressed: () {
                fun();
                Navigator.of(context).pop();
              },
              child: const Text("Rematch")),
        ],
        content: const Text(""),
      );
    },
  );
}
