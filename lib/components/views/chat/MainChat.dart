import 'dart:async';
import 'dart:convert';

import 'package:chat_app/components/views/chat/AudioPlayerWidget.dart';
import 'package:chat_app/model/GlobalStore.dart';
import 'package:chat_app/model/Classes/Message.dart';
import 'package:chat_app/model/MongoDB/GetMessages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../model/GetController.dart';

void Scroll_to_bottom(ScrollController scrollController) {
  // scroll 200 pixels down
  // hacky solution to scroll to bottom of listview
  scrollController.animateTo(
    scrollController.position.maxScrollExtent + 100,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOut,
  );
}

class MainChat extends StatefulWidget {
  const MainChat({
    Key? key,
  }) : super(key: key);

  @override
  State<MainChat> createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {
  var messageController = TextEditingController();

  String? FriendUsername;
  String? myUsername;
  final GetController getController = Get.put(GetController());

  GlobalStore globalStore = GlobalStore.getInstance();

  @override
  void initState() {
    //scroll to bottom when chat is opened

    super.initState();

    //declare scroll controller to scroll to bottom of the list

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //write or call your logic
      //code will run when widget rendering complete
      getController.scrollController.jumpTo(getController.scrollController.position.maxScrollExtent);
    });
    myUsername = globalStore.local_storage.getItem("MyUsername");
    FriendUsername = globalStore.local_storage.getItem('FriendUsername');

    get_messages();
  }

  void get_messages() async {
    GetMessages getMessages = GetMessages();
    List<Message> newMessages = [];

    newMessages = await getMessages.GetMessageList();

    setState(() {
      // rxList<Message> = newMessages List<Message>
      getController.setList(newMessages);
      // scroll to bottom of the list
      Scroll_to_bottom(getController.scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    getController.scrollController.addListener(() {
      // scroll to bottom when new message is added to the list and when chat is opened

      print("scrollController called in MainChat ${getController.scrollController.offset}");
    });

    return Scaffold(
        // on back button event
        appBar: AppBar(
          title: const Text('Chat'),
          backgroundColor: const Color(0xFF374151),
        ),
        // 20 items

        body: Container(
          //   color: const Color(0xFF111827),
          color: const Color(0xFF111827),
          child: Column(
            children: [
              Obx(
                () => Expanded(
                  // get all messages that are from void init state get_messages()
                  child: ListView.builder(
                    controller: getController.scrollController,
                    itemCount: getController.myMessages.length,
                    itemBuilder: (BuildContext listContext, int index) {
                      bool isFriend = getController.myMessages[index].sender == FriendUsername;
                      String type = getController.myMessages[index].type!;
                      String message = getController.myMessages[index].message!;
                      Widget childWidget = getWidgetMessage(type, message);

                      return ChatMessageBubble(
                        message: message,
                        isFriend: isFriend,
                        childWidget: childWidget,
                      );
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF374151),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Type a message',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF374151),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: IconButton(
                        onPressed: () {
                          var text = messageController.text;
                          print("📲 onPressed send message::: $text");

                          // add message to the list
                          var messageJson = {
                            "sender": myUsername,
                            "receiver": FriendUsername,
                            "message": text,
                            "timestamp": DateTime.now().toString(),
                            "type": "text"
                          };
                          Message message = Message.fromJson(messageJson);

                          /// send message to server
                          if (text.isNotEmpty) {
                            print("message is not empty $messageJson");
                            getController.sendMessage(jsonEncode(messageJson));
                            setState(() {
                              getController.myMessages.add(message);
                            });
                            messageController.clear();
                          }

                          /// scroll to bottom of the list
                          Scroll_to_bottom(getController.scrollController);
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class ChatMessageBubble extends StatefulWidget {
  String? message;
  bool? isFriend;

  // widget variable and add it to the constructor
  Widget childWidget = Container(
    child: Text("placeholder"),
  );

  ChatMessageBubble({Key? key, required this.message, required this.isFriend, required this.childWidget}) : super(key: key);

  @override
  State<ChatMessageBubble> createState() => _ChatMessageBubbleState();
}

class _ChatMessageBubbleState extends State<ChatMessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: widget.isFriend == true ? Alignment.centerRight : Alignment.centerLeft,
        children: [
          Container(
            // rounded corners
            decoration: BoxDecoration(
                color: widget.isFriend == true ? Colors.lightGreenAccent : Colors.lightBlueAccent,
                // border radius for the whole container except bottom right
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )),
            padding: const EdgeInsets.all(10),

            // add  index to text

            // child widget
            child: widget.childWidget,
          ),
        ],
      ),
    );
  }
}

// function to check the message type  and return the widget
Widget getWidgetMessage(String type, String message) {
  Widget childWidget = Container();

  if (type == "text") {
    childWidget = Text(
      message,
      style: const TextStyle(color: Colors.black87, fontFamily: "Arial Black", fontSize: 16),
    );
  } else if (type == "image") {
    childWidget = Image.network(message);
  } else if (type == "file") {
    childWidget = Text(
      message,
      style: const TextStyle(color: Colors.black12),
    );
  } else if (type == "audio") {
    childWidget = AudioPlayerWidget(
      audioID: message,
    );
  }
  return childWidget;
}
