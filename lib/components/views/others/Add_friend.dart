

import 'package:flutter/material.dart';

class Add_friend extends StatelessWidget {
  const Add_friend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add friend'),
        backgroundColor: const Color(0xFF374151),
        // remove the back button
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFF111827),
        child: ListView(
          // backgroundColor: const Color(0xFF374151),

          // username textfield and friend name textfield and add button
          children: [
            const SizedBox(height: 20),
            const Text('Add friend', style: TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 20),
            const Text('Username', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter username',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Friend name', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            const TextField(
              // hint text color is white
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter friend name' ,
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),

            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Add'),
            ),
          ],


        ),
      ),
    );
  }
}
