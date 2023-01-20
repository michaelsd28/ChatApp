
import 'dart:convert';
import 'dart:io';

import 'package:chat_app/model/GlobalStore.dart';
import 'package:chat_app/model/Message.dart';

class WebSocketService {
  // connect to the server and listen for messages from the server and send messages to the server



  static bool isConnected = false;

  void firstConnection()  async{


    if (isConnected) {
      return;
    }

    GlobalStore globalStore = GlobalStore.getInstance();
    String? token = globalStore.local_storage.getItem("JWT_token");
    var myUsername = globalStore.local_storage.getItem("MyUsername");

    var connectionString = "ws://10.0.0.9:8080/chat-server";
    // create a websocket connection
    WebSocket webSocket = await WebSocket.connect(connectionString);


    webSocket.listen((event) {

      var jsonBody = jsonDecode(event);

      print("Message from server: $jsonBody");

    });


    var connectionBody = {"username": myUsername, "token": token};

    if (!isConnected) {
      String connectionBodyString = jsonEncode(connectionBody);
      webSocket.add(connectionBodyString);
      print("connection body is $connectionBodyString connection was executed");
      isConnected = true;
    }
  }
}
