import 'FriendUser.dart';

class User {
    late String? name;
    late String? username;
    late String? password;
    late String? userImage;
    List<FriendUser>? friends;

    User({
      this.name,
      this.username,
      this.password,
      this.userImage,
      this.friends
    });
}
