import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainChat extends StatelessWidget {
  const MainChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                borderRadius: index % 2 == 0 ? BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ) : BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),

                              ),
                            padding: const EdgeInsets.all(10),

                              child: Text('Message needs to be very long .',  style: TextStyle(fontSize: 16),),
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
                      child: const Icon(
                        Icons.send,
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
