
import 'package:chat_app/model/GlobalStore.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chat_app/model/RegisterUser.dart';
// import mongodb dart driver
import 'package:mongo_dart/mongo_dart.dart';
// import to map
import 'dart:convert';

import 'Operations.dart';


class InsertUser implements Operation {

  late RegisterUser user;


  InsertUser(this.user);




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
      if (kDebugMode) {
        print(await response.stream.bytesToString());
      }
    }
    else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }





    print("insert user in localhost:8080/register with post method and json body ${user.toJson()}");





  }


}