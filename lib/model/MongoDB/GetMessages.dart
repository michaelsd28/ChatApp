import 'dart:convert';

import 'package:chat_app/model/Classes/Message.dart';
import 'package:chat_app/model/MongoDB/Operations.dart';
import 'package:http/http.dart' as http;

import '../GlobalStore.dart';

class GetMessages   {


  GetMessages();



  GlobalStore store = GlobalStore.getInstance();

  Future<List<Message>> GetMessageList() async {


    String token = store.local_storage.getItem("JWT_token");
    String FriendUserName = store.local_storage.getItem("FriendUsername");


    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://10.0.0.174:8080/get-messages'));



    request.body = json.encode({ "friend_username": FriendUserName, "JWT_token": token });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    List<Message> messages = [];



    if (response.statusCode == 200) {


      var responseBody = await response.stream.bytesToString();




      var jsonBody = jsonDecode(responseBody);

      // print messages in the array of jsonBody
      for (var message in jsonBody) {

        messages.add(Message.fromJson(message));
      }










      return messages;

    }
    else {
      print(response.reasonPhrase);
      return messages;
    }

  }
}
