
import 'dart:convert';

import 'package:chat_app/model/GlobalStore.dart';
import 'package:chat_app/model/MongoDB/Operations.dart';
// import http
import 'package:http/http.dart' as http;

class AddFriend_widget implements Operation {

  String name;
  String username;



  AddFriend_widget(this.name, this.username);

  @override
  Future<void> execute() async {

    var globalStore = GlobalStore.getInstance();
    var token = globalStore.local_storage.getItem("JWT_token");


    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://localhost:8080/add-friend'));
    request.body = json.encode({
      "name": name,
      "username": username,
      "token": token
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    //var status document.getElementById("status");
    var document = await response.stream.bytesToString();
   var  documentJson = jsonDecode(document);

    if(documentJson["status"] == "success"){

      globalStore.local_storage.setItem("isInserted", true);
    }
    else{

      globalStore.local_storage.setItem("isInserted", false);

    }



  }


}