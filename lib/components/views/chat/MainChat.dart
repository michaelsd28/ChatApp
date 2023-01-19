import 'package:chat_app/model/FriendUser.dart';
import 'package:chat_app/model/GlobalStore.dart';
import 'package:chat_app/model/Message.dart';
import 'package:chat_app/model/MongoDB/GetMessages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';


void Scroll_to_bottom( ScrollController scrollController) {
  scrollController.animateTo(
    scrollController.position.maxScrollExtent,
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

  final ScrollController scrollController = ScrollController(   keepScrollOffset: true,);

  String? friendUsername;

  @override
  void initState() {
    //scroll to bottom when chat is opened


    super.initState();

    //declare scroll controller to scroll to bottom of the list


    WidgetsBinding.instance.addPostFrameCallback((_){
      //write or call your logic
      //code will run when widget rendering complete
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });

    get_messages();

    GlobalStore globalStore = GlobalStore.getInstance();

     friendUsername = globalStore.local_storage.getItem('FriendUsername');


  }

  List<Message> messages = [];



  void get_messages() async {



    GetMessages getFriends = GetMessages();
    List<Message> newMessages = [];

    newMessages = await  getFriends.GetMessageList();

    setState(() {

      messages = newMessages;




    });

  }

  @override
  Widget build(BuildContext context) {



    scrollController.addListener(() {
      // scroll to bottom when new message is added to the list and when chat is opened
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
         Scroll_to_bottom(scrollController);
      }

      print("scrollController called in MainChat ${scrollController.offset}");
    });








    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          backgroundColor: const Color(0xFF374151),
        ),
        // 20 items

        // in the body i want a text bubble with a message and a limited size of 200px and a scrollable list of messages and is in a listview.builder
        // i want to add a textfield and a send button

        body: Container(
          color: const Color(0xFF111827),
          child: Column(
            children: [
              Expanded(
                // get all messages that are from void init state get_messages()
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return messages[index].sender == friendUsername ?  FriendBubble(message: messages[index].message!) : ChatBubble (message: messages[index].message!);
                  },


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
                    const Expanded(
                      child: TextField(

                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
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
                      child:  IconButton(
                        onPressed: () {
                          // add message to the list
                          // scroll to bottom
                          Scroll_to_bottom(scrollController);
                        },
                        icon: const Icon(Icons.send, color: Colors.white,),
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


class ChatBubble extends StatelessWidget {

  String? message;


   ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack (
        alignment:  Alignment.centerRight,
        children: [
          Container(
            // rounded corners
            decoration: const BoxDecoration(
              color:   Colors.lightBlueAccent,
              // border radius for the whole container except bottom right
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),

            ),
            padding: const EdgeInsets.all(10),


            // add  index to text

            child:   Text(message!,  style: TextStyle(fontSize: 16),),
          ),
        ],
      ),

    );
  }
}



class FriendBubble extends StatelessWidget {

  String? message;

    FriendBubble({Key? key, required this.message }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack (
        alignment:  Alignment.centerLeft ,
        children: [
          Container(
            // rounded corners
            decoration: const BoxDecoration(
              color: Colors.lightGreenAccent ,
              // border radius for the whole container except bottom right
              borderRadius:  BorderRadius.only(
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )

            ),
            padding: const EdgeInsets.all(10),


            // add  index to text

            child:   Text(message!,  style: TextStyle(fontSize: 16),),
          ),
        ],
      ),

    );
  }
}

