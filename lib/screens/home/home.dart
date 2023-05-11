import 'dart:io';

import 'package:chess_game/screens/game_modes/ai_mode.dart';
import 'package:chess_game/screens/game_modes/user_v_user.dart';
import 'package:chess_game/screens/profile/profile.dart';
import 'package:chess_game/services/socket/socket_stuffs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool touch = false;
  SocketStuffs? ss;
  @override
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: touch,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Profile",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 25, child: Image.asset("assets/logo2.jpg")),
                        const Text(
                          "Chess",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff95BB4A),
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        final storage = GetStorage();
                        String userEmail = storage.read('email') ?? "false";
                        print(userEmail);
                        Get.to(ProfileScreen(email: userEmail));
                      },
                      child: const Text(
                        "Profile",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () {
                  Get.to(UserVsScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/chess.png"),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "V/S Mode",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Play against each other in \nsame device",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withOpacity(0.7),
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Image.asset("assets/hat.png", height: 50, width: 50)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              InkWell(
                onTap: () {
                  Get.to(AiModeScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/chess.png"),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "AI Mode",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Play against AI",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withOpacity(0.7),
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Image.asset("assets/ai.png", height: 50, width: 50)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              InkWell(
                onTap: () async {
                  setState(() {
                    // touch = true;
                  });
                  EasyLoading.show(status: 'loading...');
                  ss = SocketStuffs();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/chess.png"),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Online Mode",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Play against other users in\nonline mode",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withOpacity(0.7),
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Image.asset("assets/trophy.png",
                              height: 50, width: 50)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
