import 'dart:convert';

import 'package:chat_app/model/GlobalStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'Classes/Message.dart';

class GetController extends GetxController {
  final myMessages = <Message>[].obs;


   ScrollController scrollController = ScrollController(
    keepScrollOffset: false,
  );

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

    channel?.stream.listen((event) {
      dynamic messageJson = jsonDecode(event);

      var message = Message.fromJson(messageJson);

      var myUsername = GlobalStore.getInstance().local_storage.getItem("MyUsername");

      /// if the message is not from me
      if (message.receiver == myUsername) {
        myMessages.add(message);

        /// scroll to bottom of the list



        // scrollController is not working here because the list is not rendered yet
        // so we need to use the post frame callback
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });




        /// update the list
        update();
      }
    });

    super.onInit();
  }
}
