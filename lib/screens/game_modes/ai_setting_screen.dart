import 'package:chess_game/screens/game_modes/ai_mode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AISettingScreen extends StatefulWidget {
  AISettingScreen({Key? key}) : super(key: key);

  @override
  State<AISettingScreen> createState() => _AISettingScreenState();
}

class _AISettingScreenState extends State<AISettingScreen> {
  int difficulty = 2;
  bool isWhite = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Game Settings",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Difficulty",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff95BB4A),
                      fontWeight: FontWeight.w600),
                ),
                Container()
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      difficulty = 1;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: (difficulty == 1)
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: const Center(
                      child: Text(
                        "Easy",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      difficulty = 2;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: (difficulty == 2)
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: const Center(
                      child: Text(
                        "Medium",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      difficulty = 3;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: (difficulty == 3)
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: const Center(
                      child: Text(
                        "Hard",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Play As",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff95BB4A),
                      fontWeight: FontWeight.w600),
                ),
                Container()
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isWhite = true;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: (isWhite) ? Colors.white : Colors.transparent,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Row(
                        children: [
                          Image.asset("assets/pieces/wk.png"),
                          const SizedBox(width: 5),
                          const Text(
                            "White",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isWhite = false;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: (!isWhite) ? Colors.white : Colors.transparent,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Row(
                        children: [
                          Image.asset("assets/pieces/bk.png"),
                          const SizedBox(width: 5),
                          const Text(
                            "Black",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 100),
            InkWell(
              onTap: () {
                Get.to(AiModeScreen(difficulty: difficulty, isWhite: isWhite));
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff95BB4A),
                ),
                child: const Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
