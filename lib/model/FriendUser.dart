import 'Message.dart';

class FriendUser {
  String? name;
  String? username;
  String? image;
  String? lastMessage;
  List<Message>? messages;

  FriendUser({
        this.name,
        this.username,
        this.image,
        this.lastMessage,
        this.messages
      });


}
