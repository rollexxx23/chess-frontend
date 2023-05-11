import 'package:chess_game/models/auth/profile.dart';
import 'package:chess_game/models/game/match.dart';
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
                                        child: Center(
                                          child: Text(
                                            snapshot.data!.username[0]
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.white),
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
                                        children: [
                                          const SizedBox(width: 5),
                                          Text(
                                            "Joined: ${snapshot.data!.dateJoined}",
                                            style: const TextStyle(
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
                                    child: Center(
                                      child: Text(
                                        "${snapshot.data!.winCnt}",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: (MediaQuery.of(context).size.width -
                                            20) /
                                        3,
                                    height: 40,
                                    color: Colors.orange,
                                    child: Center(
                                      child: Text(
                                        "${snapshot.data!.drawCnt}",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: (MediaQuery.of(context).size.width -
                                            20) /
                                        3,
                                    height: 40,
                                    color: Colors.red,
                                    child: Center(
                                      child: Text(
                                        "${snapshot.data!.lossCnt}",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }
                    }
                  }),
              FutureBuilder(
                  future: ProfileAPI()
                      .getMatchList("arin2@gmail.com"), // async work
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MatchModel>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Text('Loading....');
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Column(
                            children: [
                              const Text(
                                "Completed Games (0)",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              const SizedBox(height: 10),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: matchWidget(
                                              snapshot.data![index]),
                                        ));
                                  }),
                            ],
                          );
                        }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

Widget matchWidget(MatchModel model) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.square,
                      color: Colors.white,
                      size: 15,
                    ),
                    Text(
                      model.whitePlayerUserName,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.square,
                      color: Colors.black,
                      size: 15,
                    ),
                    Text(
                      model.blackPlayerUserName,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  model.comment,
                  style: const TextStyle(color: Colors.green, fontSize: 14),
                ),
                const SizedBox(width: 10),
                Text(
                  "(${model.moves} moves)",
                  style: const TextStyle(color: Colors.white, fontSize: 14),
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
