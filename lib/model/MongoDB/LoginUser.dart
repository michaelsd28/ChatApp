import 'dart:convert';

import 'package:chat_app/model/MongoDB/Operations.dart';
import 'package:chat_app/model/Classes/User.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// add http package
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../GetController.dart';
import '../GlobalStore.dart';

class LoginUser implements Operation {
  late User user;

  GetController getController = Get.put(GetController());

  LoginUser(this.user);

  @override
  Future<void> execute() async {
    /* add and accept cors */
    var headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE',
      'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    };
    // var request = http.Request('POST', Uri.parse('http://10.0.0.174:8080/login'));
    var requestUrl = "http://10.0.0.9:8080/login";
    var uri = Uri.parse(requestUrl);
    var request = http.Request('POST', uri);
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

      var username = jsonBody["user"];


      // store.local_storage.setItem("JWT_token", token);
      // store.local_storage.setItem("_MyUsername", username);

      getController.jwtToken = token;

      print("LoginUser:: jsonBody:: $jsonBody * token:: $token * username:: $username");

    } else if (status == 'fail') {
      // store.local_storage.setItem("JWT_token", null);
      getController.jwtToken = null.toString();
    }
  }
}
