
import 'dart:convert';

import 'package:chat_app/model/GlobalStore.dart';
import 'package:chat_app/model/MongoDB/Operations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:http/http.dart' as http;

import '../GetController.dart';

class AddMessages implements Operation{


  String? message;
  GetController getController = Get.put(GetController());


  AddMessages(this.message);

  @override
  Future<void> execute() async {

    GlobalStore globalStore = GlobalStore.getInstance();
    String? token = getController.jwtToken;
    var receiver = getController.FriendUsername;
    var sender = getController.myUsername;

    var headers = {'Content-Type': 'application/json' , 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE', 'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept, Authorization'};
    var request = http.Request('POST', Uri.parse('http://10.0.0.9:8080/add-messages'));
    request.body = json.encode({
      "token": token,
      "message": message,
      "type": "type",
      "receiver": receiver,
      "sender": sender,
      "time": "time"
    });
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