// import dart:io
 import 'dart:convert';
import 'dart:io';

class WebSocketService{

  // connect to the server and listen for messages from the server and send messages to the server

 static void connect() async{
    // create a websocket connection
    WebSocket ws = await WebSocket.connect("ws://10.0.0.9:8080/echo");
    // listen for messages from the server
    ws.listen((message) {
      print("Received message from server: $message");
    });
    // send a message to the server

   var json = {
     "id": "string",
     "type": "string",
     "token": "string"
   };

    ws.add(jsonEncode(json));

  }


}