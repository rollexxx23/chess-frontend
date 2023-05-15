import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart'
    show Chessboard;
import 'package:get/get.dart';

class ReplayScreen extends StatefulWidget {
  ReplayScreen({super.key, required this.fen});
  String fen;

  @override
  State<ReplayScreen> createState() => _ReplayScreenState();
}

class _ReplayScreenState extends State<ReplayScreen> {
  List<String> states = [];
  int cur = 0;

  @override
  void initState() {
    // TODO: implement initState
    states.add("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1");
    states.addAll(widget.fen.split(','));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Replay",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Text(
              "Move: $cur",
              style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xff95BB4A),
                  fontWeight: FontWeight.w400),
            ),
            Chessboard(
              fen: states[cur],
              size: MediaQuery.of(context).size.width,
              onMove: (move) {},
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      cur = max(0, cur - 1);
                    });
                  },
                  child: const Icon(Icons.arrow_circle_left_rounded,
                      color: Colors.white, size: 40),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      cur = min(states.length - 1, cur + 1);
                    });
                  },
                  child: const Icon(Icons.arrow_circle_right_rounded,
                      color: Colors.white, size: 40),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
