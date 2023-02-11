import 'dart:convert';

import 'package:chat_app/model/Classes/Message.dart';
import 'package:chat_app/model/GetController.dart';
import 'package:chat_app/model/MongoDB/Operations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../GlobalStore.dart';

class GetMessages {
  GetMessages();

  GlobalStore store = GlobalStore.getInstance();

  GetController getController = Get.put(GetController());

  Future<List<Message>> GetMessageList() async {
    String token = getController.jwtToken;
    String FriendUserName = getController.FriendUsername;
    var myUsername = getController.myUsername;
    print("GetMessages:: myUsername:: $myUsername * FriendUserName:: $FriendUserName * token:: $token");

    var headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    };

    var uriAddress = Uri.parse('http://10.0.0.9:8080/get-messages');

    var request = http.Request('POST', uriAddress);



    var body = {"friend_username": FriendUserName, "username": myUsername, "JWT_token": token};



    request.body = json.encode(body);
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
    } else {
      print(response.reasonPhrase);
      return messages;
    }
  }
}
