
import 'dart:convert';

import 'package:chat_app/model/GlobalStore.dart';
import 'package:chat_app/model/MongoDB/Operations.dart';

import 'package:http/http.dart' as http;

class AddMessages implements Operation{


  String? message;

  AddMessages(this.message);

  @override
  Future<void> execute() async {

    GlobalStore globalStore = GlobalStore.getInstance();
    String? token = globalStore.local_storage.getItem("JWT_token");
    var receiver = globalStore.local_storage.getItem("FriendUsername");
    var sender = globalStore.local_storage.getItem("MyUsername");

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://localhost:8080/add-messages'));
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