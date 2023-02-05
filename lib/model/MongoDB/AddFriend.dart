
import 'dart:convert';

import 'package:chat_app/model/GlobalStore.dart';
import 'package:chat_app/model/MongoDB/Operations.dart';
// import http
import 'package:http/http.dart' as http;

class AddFriend_Service implements Operation {

  String name;
  String username;



  AddFriend_Service(this.name, this.username);

  @override
  Future<void> execute() async {

    var globalStore = GlobalStore.getInstance();
    var token = globalStore.local_storage.getItem("JWT_token");
/// allow all cors
    var headers = {
      'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE', 'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept, Authorization', 'Access-Control-Allow-Credentials': 'true'
    };
    var request = http.Request('POST', Uri.parse('http://10.0.0.9:8080/add-friend'));
    request.body = json.encode({
      "name": name,
      "username": username,
      "token": token
    });
    request.headers.addAll(headers);

    print("request body: ${request.body}");

    http.StreamedResponse response = await request.send();

    print("response is -> $response ");

    var body = await response.stream.bytesToString();
    var bodyJson = jsonDecode(body);


    /*"status": "success"*/
    /* "status": "fail" */

    if (bodyJson["status"] == "success") {
      print("AddFriend_Service::  ${await response.stream.bytesToString()}");
      globalStore.local_storage.setItem("isFriendAdded","true");
    }
    else if (bodyJson["status"] == "fail") {
      print("AddFriend_Service::  ${await response.stream.bytesToString()}");
      globalStore.local_storage.setItem("isFriendAdded","false");
    }




  }


}