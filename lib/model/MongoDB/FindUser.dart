import 'package:chat_app/model/MongoDB/Operations.dart';
import 'package:flutter/foundation.dart';

// import http package
import 'package:http/http.dart' as http;

import '../User.dart';

class FindUser implements Operation {
  User user;

  FindUser(this.user);

  @override
  Future<void> execute() async {
    if (kDebugMode) {
      print(
          "find user in localhost:8080/register with post method and json body");
    }

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://10.0.0.9:8080/find'));
     request.body = '''{
        "username": "${user.username}",
        "password": "${user.password}",
      }''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("response status code: ${response.statusCode} * response body: ${await response.stream.bytesToString()}");

  }
}
