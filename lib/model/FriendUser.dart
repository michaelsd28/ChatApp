import 'Message.dart';

class FriendUser {
  String? id;
  String? name;
  String? email;
  String? photoUrl;
  String? status;
  String? lastMessage;
  List<Message>? messages;

  FriendUser(
      {this.id,
      this.name,
      this.email,
      this.photoUrl,
      this.status,
      this.lastMessage,
      this.messages});
}
