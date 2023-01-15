import 'FriendUser.dart';

class User {
  late String name;
  late String username;
  late String password;
  late String userImage;
  List<FriendUser>? friends;

  User(
      {required this.name,
      required this.username,
      required this.password,
      required this.userImage,
      this.friends});
}
