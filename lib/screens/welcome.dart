import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    "Log In",
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
                  const Text(
                    "Log In",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Text(
              "Create Your\n Chess Account",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Center(child: Image.asset("assets/logo.png")),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xff95BB4A),
              ),
              child: const Center(
                child: Text(
                  'Sign Up With Email',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
