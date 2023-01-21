import 'dart:convert';

import 'package:chat_app/model/GlobalStore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'Message.dart';

class GetController extends GetxController {
  var count = 0.obs;

  void increment() => count++;

  final myMessages = <Message>[].obs;

// add to list if timestamp is not in list
  void addToList(Message item) {
    bool isFound = false;
    for (var i = 0; i < myMessages.length; i++) {
      if (myMessages[i].timestamp == item.timestamp) {
        isFound = true;
      }
    }
    if (!isFound) {
      myMessages.add(item);
    }
  }

  void removeFromList(Message item) => myMessages.remove(item);

  void updateList(int index, Message item) => myMessages[index] = item;

  void setList(List<Message> newList) => myMessages.assignAll(newList);

  late final WebSocketChannel? channel;

  void sendMessage(String message) {
    channel!.sink.add(message);
  }

  @override
  void dispose() {
    channel!.sink.close();
    super.dispose();
  }

  @override
  void onInit() {
    channel = WebSocketChannel.connect(
      Uri.parse("ws://10.0.0.9:8080/chat-server"),
    );

    GlobalStore store = GlobalStore.getInstance();
    String token = store.local_storage.getItem("JWT_token");
    String MyUsername = store.local_storage.getItem("MyUsername");
    channel!.sink.add(jsonEncode({"username": MyUsername, "token": token}));
    super.onInit();
  }
}
