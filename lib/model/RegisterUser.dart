import 'dart:io';

class RegisterUser {
  String name;
  String username;
  String password;
  String userImage;

  RegisterUser(
      {required this.name,
      required this.username,
      required this.password,
      required this.userImage});



  String toJson() {
    return '{'
        '"name": "$name",'
        '"username": "$username",'
        '"password": "$password",'
        '"image": "$userImage"'
        '}';
  }
}
