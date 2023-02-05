
import 'package:chat_app/model/GlobalStore.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chat_app/model/Classes/RegisterUser.dart';
// import mongodb dart driver

// import to map
import 'dart:convert';

import 'Operations.dart';


class SignUp implements Operation {

  late RegisterUser user;


  SignUp(this.user);




  GlobalStore store = GlobalStore.getInstance();

  @override
  Future<void> execute() async {




    var headers = {
      'Content-Type': 'application/json' ,
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE',
      'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, '
          'Accept, Authorization'
    };
    var request = http.Request('POST', Uri.parse('http://10.0.0.9:8080/register'));
    request.body = user.toJson();
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("response is $response ");

    // {"status":"success"}
    // {"status":"fail"}

    var json = await response.stream.bytesToString();
    var jsonBody = jsonDecode(json);

    print("jsonBody is $jsonBody");

    if (jsonBody['status'] == 'success') {
      store.local_storage.setItem("DidSignUp", "true");
    } else if (jsonBody['status'] == 'fail') {
      store.local_storage.setItem("DidSignUp", "false");
    }




  }


}