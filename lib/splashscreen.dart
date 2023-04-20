import 'dart:async';
import 'package:chess_game/screens/home/home.dart';
import 'package:chess_game/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  initFunc() async {
    final storage = GetStorage();
    bool isLoggedIn = storage.read('loggedIn') ?? false;
    print(isLoggedIn);
    if (isLoggedIn == false) {
      Timer(const Duration(seconds: 5), () {
        Navigator.pop(context);
        Get.to(const WelcomeScreen(), transition: Transition.fadeIn);
      });
    } else {
      Timer(const Duration(seconds: 5), () {
        Navigator.pop(context);
        Get.to(const HomeScreen(), transition: Transition.fadeIn);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hello ");
    initFunc();
    // after 2 Seconds it will move to login screen
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // fetch screen size
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: "splashlogo",
                child: Image.asset(
                  "assets/logo.png",
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: const [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
