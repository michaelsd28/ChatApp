import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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

    print("initState called in MainChat");

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
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 20,
                  itemBuilder: (context, index) {

                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack (
                        alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
                        children: [
                          Container(
                              // rounded corners
                              decoration: BoxDecoration(
                                color: index % 2 == 0 ?  Colors.lightGreenAccent :  Colors.lightBlueAccent,
                                // border radius for the whole container except bottom right
                                borderRadius: index % 2 == 0 ? const BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ) : const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),

                              ),
                            padding: const EdgeInsets.all(10),


                              // add  index to text

                              child:  Text('Message from user very long $index',  style: TextStyle(fontSize: 16),),
                          ),
                        ],
                      ),

                    );
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
