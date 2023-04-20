import 'package:chess_game/models/auth/user_reg.dart';
import 'package:chess_game/services/auth/auth_services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen3 extends StatefulWidget {
  String email;
  String password;
  RegisterScreen3({super.key, required this.email, required this.password});

  @override
  State<RegisterScreen3> createState() => _RegisterScreen3State();
}

class _RegisterScreen3State extends State<RegisterScreen3> {
  TextEditingController userTextController = TextEditingController();
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
                    "Choose a username",
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
                    "This is what your friends and other players\nwill see when you play",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 100,
                      child: CountryCodePicker(
                        onChanged: print,
                        padding: EdgeInsets.all(2.0),
                        backgroundColor: Colors.black,
                        initialSelection: 'IN',
                        textStyle: TextStyle(color: Colors.white),
                        showCountryOnly: true,
                        // optional. Shows only country name and flag when popup is closed.
                        showOnlyCountryWhenClosed: true,

                        alignLeft: false,
                      ),
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
                      width: MediaQuery.of(context).size.width - 150,
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
                              width: MediaQuery.of(context).size.width - 250,
                              // height: 30,

                              child: TextField(
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                controller: userTextController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Username',
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
                    String? msg = await AuthServices.registerUser(
                        UserRegisterModel(
                            email: widget.email,
                            password: widget.password,
                            username: userTextController.text));
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
                        'Create Account',
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
