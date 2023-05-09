import 'package:web_socket_channel/web_socket_channel.dart';

class OnlineGameModel {
  String blackUser;
  String whiteUser;
  bool isWhite;
  WebSocketChannel channel;
  int id;
  String myEmail;
  OnlineGameModel(
      {required this.blackUser,
      required this.whiteUser,
      required this.channel,
      required this.myEmail,
      required this.id,
      required this.isWhite});
}
