import 'package:chess_game/screens/register/register2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen1 extends StatefulWidget {
  const RegisterScreen1({super.key});

  @override
  State<RegisterScreen1> createState() => _RegisterScreen1State();
}

class _RegisterScreen1State extends State<RegisterScreen1> {
  TextEditingController emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
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
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "What is your email?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.7),
                      width: 1,
                    ),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width - 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 150,
                          // height: 30,

                          child: TextField(
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            controller: emailTextController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(RegisterScreen2(
                      email: emailTextController.text,
                    ));
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
                const SizedBox(height: 20)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
