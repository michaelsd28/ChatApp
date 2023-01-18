import 'package:chat_app/model/GlobalStore.dart';
import 'package:chat_app/model/MongoDB/MongoDBService.dart';
import 'package:flutter/material.dart';

import '../../../model/MongoDB/AddFriend.dart';

class Add_friend extends StatelessWidget {
  const Add_friend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var usernameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add friend'),
        backgroundColor: const Color(0xFF374151),
        // remove the back button
        automaticallyImplyLeading: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFF111827),
        child: ListView(
          // backgroundColor: const Color(0xFF374151),

          // username textfield and friend name textfield and add button
          children: [
            const SizedBox(height: 20),
            const Text('Add friend',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 20),
            const Text('Username', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter username',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Friend name', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              // hint text color is white
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter friend name',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var username = usernameController.text;
                var name = nameController.text;

                await insertUser(username, name, context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  insertUser(String username, String name, BuildContext context) async {
    AddFriend_widget addFriend = AddFriend_widget(name, username);
    MongoDBService mongoDBService = MongoDBService(addFriend);
    await mongoDBService.execute();

    GlobalStore globalStore = GlobalStore.getInstance();

    var isInserted = globalStore.local_storage.getItem("isInserted");

    // snackbar to show if the user is added or not
    if (isInserted == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User added'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not added'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
