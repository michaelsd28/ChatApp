
import 'package:chat_app/model/GlobalStore.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chat_app/model/RegisterUser.dart';
// import mongodb dart driver

// import to map
import 'dart:convert';

import 'Operations.dart';


class SignUp implements Operation {

  late RegisterUser user;


  SignUp(this.user);




  @override
  Future<void> execute() async {




    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://10.0.0.9:8080/register'));
    request.body = user.toJson();
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }



  }


}