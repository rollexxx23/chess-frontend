class ProfileModel {
  String username;
  String email;
  String country;
  int winCnt;
  int drawCnt;
  int lossCnt;

  ProfileModel(
      {required this.country,
      required this.drawCnt,
      required this.email,
      required this.lossCnt,
      required this.username,
      required this.winCnt});
}
