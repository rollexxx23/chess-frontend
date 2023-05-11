import 'package:chess_game/models/auth/profile.dart';
import 'package:chess_game/services/profile/profile_api.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: ProfileAPI().getProfileDetails("arin2@gmail.com"),
                  builder: (BuildContext context,
                      AsyncSnapshot<ProfileModel?> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Text('Loading....');
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        color: const Color(0xffEC407A),
                                        child: const Center(
                                          child: Text(
                                            'A',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15)
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(width: 5),
                                          Text(
                                            snapshot.data!.username,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      CountryCodePicker(
                                        onChanged: null,
                                        padding: const EdgeInsets.all(2.0),
                                        backgroundColor: Colors.black,
                                        initialSelection:
                                            snapshot.data!.country == ""
                                                ? 'US'
                                                : snapshot.data!.country,
                                        textStyle: const TextStyle(
                                            color: Colors.white),
                                        showCountryOnly: true,
                                        showOnlyCountryWhenClosed: true,
                                        enabled: false,
                                        alignLeft: false,
                                      ),
                                      Row(
                                        children: const [
                                          SizedBox(width: 5),
                                          Text(
                                            "Joined: 14/10/23",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width -
                                            20) /
                                        3,
                                    height: 40,
                                    color: Colors.green,
                                  ),
                                  Container(
                                    width: (MediaQuery.of(context).size.width -
                                            20) /
                                        3,
                                    height: 40,
                                    color: Colors.orange,
                                  ),
                                  Container(
                                    width: (MediaQuery.of(context).size.width -
                                            20) /
                                        3,
                                    height: 40,
                                    color: Colors.red,
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }
                    }
                  }),
              Column(
                children: [
                  const Text(
                    "Completed Games (0)",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: matchWidget(),
                            ));
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget matchWidget() {
  return Container(
    height: 50,
    color: const Color(0xff747474),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.square,
                      color: Colors.white,
                      size: 15,
                    ),
                    Text(
                      "arinc23",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(
                      Icons.square,
                      color: Colors.black,
                      size: 15,
                    ),
                    Text(
                      "arinc23",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "1-0",
                  style: TextStyle(color: Colors.green, fontSize: 14),
                ),
                SizedBox(width: 10),
                Text(
                  "(35 moves)",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Review",
                  style: TextStyle(
                      color: Color(0xff5694B0),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff5694B0),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
