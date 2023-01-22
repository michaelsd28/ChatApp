import 'dart:convert';

import 'package:chat_app/model/MongoDB/Operations.dart';
import 'package:chat_app/model/Classes/User.dart';

// add http package
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../GlobalStore.dart';

class LoginUser implements Operation {
  late User user;

  LoginUser(this.user);

  @override
  Future<void> execute() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://10.0.0.9:8080/login'));
    request.body = json.encode({"username": user.username, "password": user.password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    var jsonBody = jsonDecode(responseBody);
    var status = jsonBody['status'];
    // get jwt token

    GlobalStore store = GlobalStore.getInstance();

    if (status == 'success') {
      String token = jsonBody["token"];


      print("token is $token");

      store.local_storage.setItem("JWT_token", token);
      store.local_storage.setItem("MyUsername", user.username);
    } else if (status == 'fail') {
      store.local_storage.setItem("JWT_token", null);
    }
  }
}
