import 'package:chess_game/models/auth/user_login.dart';
import 'package:chess_game/services/auth/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController pwTextController = TextEditingController();
  String errorMsg = "";
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
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Center(
                  child: Text(
                    "Login using your email/ username",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.withOpacity(0.7),
                        fontWeight: FontWeight.w500),
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
                          Icons.person,
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
                              hintText: 'Username or Email',
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
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
                          Icons.lock,
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
                            controller: pwTextController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
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
                const SizedBox(height: 30),
                Text(
                  errorMsg,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: () async {
                    String? msg = await AuthServices.loginUser(UserLoginModel(
                        email: emailTextController.text,
                        password: pwTextController.text));

                    if (msg != null) {
                      setState(() {
                        errorMsg = msg;
                      });
                    }
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
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Forgot Password',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff95BB4A),
                      fontSize: 15),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
