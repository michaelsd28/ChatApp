import 'dart:async';
import 'dart:convert';

import 'package:chat_app/model/GlobalStore.dart';
import 'package:chat_app/model/Message.dart';
import 'package:chat_app/model/MongoDB/GetMessages.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
  const MainChat({Key? key}) : super(key: key);

  @override
  State<MainChat> createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {
  final ScrollController scrollController = ScrollController(
    keepScrollOffset: false,
  );

  var messageController = TextEditingController();
  GlobalStore globalStore = GlobalStore.getInstance();
  String? FriendUsername;
  String? myUsername;
  List<Message> messages = [];
  late final WebSocketChannel? _channel;

  // receive  messages from server and add to messages list

  static bool isConnected = false;

  void SocketConnection() async {
    _channel = globalStore.GetChannel();
    String? token = globalStore.local_storage.getItem("JWT_token");
    myUsername = globalStore.local_storage.getItem("MyUsername");

    print("SocketConnection was executed broadcast ${_channel!.stream.isBroadcast}");

    // remove the stream listener if it exists to avoid multiple listeners

    var connectionBody = {"username": myUsername, "token": token};
    if (!isConnected || _channel == null) {
      String connectionBodyString = jsonEncode(connectionBody);
      _channel!.sink.add(connectionBodyString);
      print("connection body is $connectionBodyString connection was executed");
      isConnected = true;
    }

    // add new stream listener to channel

    _channel!.stream.listen((event) {
      var jsonBody = jsonDecode(event);
      print("Message from server: $jsonBody");
      var message = Message(
          sender: jsonBody["sender"],
          receiver: jsonBody["receiver"],
          message: jsonBody["message"],
          timestamp: jsonBody["timestamp"],
          type: jsonBody["type"]);
      setState(() {
        messages.add(message);
      });
      Scroll_to_bottom(scrollController);
    }).onDone(() {
      print("Socket connection was closed");


    });
  }

  @override
  void initState() {
    //scroll to bottom when chat is opened

    super.initState();

    //declare scroll controller to scroll to bottom of the list

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //write or call your logic
      //code will run when widget rendering complete
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });

    FriendUsername = globalStore.local_storage.getItem('FriendUsername');
    get_messages();
    SocketConnection();
  }

  void get_messages() async {
    GetMessages getMessages = GetMessages();
    List<Message> newMessages = [];

    newMessages = await getMessages.GetMessageList();

    setState(() {
      messages = newMessages;
      // scroll to bottom of the list
      Scroll_to_bottom(scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      // scroll to bottom when new message is added to the list and when chat is opened

      print("scrollController called in MainChat ${scrollController.offset}");
    });

    return Scaffold(
        // on back button event
        appBar: AppBar(
          title: const Text('Chat'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // go back to previous page


              Navigator.pop(context);

            },
          ),
          backgroundColor: const Color(0xFF374151),
        ),
        // 20 items

        body: Container(
          //   color: const Color(0xFF111827),
          color: const Color(0xFF111827),
          child: Column(
            children: [
              Expanded(
                  // get all messages that are from void init state get_messages()
                  child: ListView.builder(
                controller: scrollController,
                itemCount: messages.length,
                itemBuilder: (BuildContext listContext, int index) {
                  return messages[index].sender == FriendUsername
                      ? FriendBubble(message: messages[index].message!)
                      : ChatBubble(message: messages[index].message!);
                },
              )),
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

                          // add message to the list
                          var messageJson = {
                            "sender": myUsername,
                            "receiver": FriendUsername,
                            "message": text,
                            "timestamp": DateTime.now().toString(),
                            "type": "text"
                          };
                          Message message = Message.fromJson(messageJson);
                          setState(() {
                            messages.add(message);
                          });
                          messageController.clear();

                          /// send message to server
                          if (text.isNotEmpty) {
                            _channel?.sink.add(jsonEncode(messageJson));
                            messageController.clear();
                          }

                          /// scroll to bottom of the list
                          Scroll_to_bottom(scrollController);
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

class ChatBubble extends StatefulWidget {
  String? message;

  ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            // rounded corners
            decoration: const BoxDecoration(
              color: Colors.lightBlueAccent,
              // border radius for the whole container except bottom right
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(10),

            // add  index to text

            child: Text(
              widget.message!,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class FriendBubble extends StatefulWidget {
  String? message;

  FriendBubble({Key? key, required this.message}) : super(key: key);

  @override
  State<FriendBubble> createState() => _FriendBubbleState();
}

class _FriendBubbleState extends State<FriendBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            // rounded corners
            decoration: const BoxDecoration(
                color: Colors.lightGreenAccent,
                // border radius for the whole container except bottom right
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )),
            padding: const EdgeInsets.all(10),

            // add  index to text

            child: Text(
              widget.message!,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
