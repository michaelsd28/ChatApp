import 'package:chat_app/components/views/chat/MainChat.dart';
import 'package:chat_app/components/views/others/AddFriend_widget.dart';
import 'package:chat_app/model/GlobalStore.dart';
import 'package:flutter/material.dart';

import '../../../model/FriendUser.dart';
import '../../../model/MongoDB/GetFriends.dart';
import '../../../model/MongoDB/GetMessages.dart';
import '../../../model/MongoDB/MongoDBService.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<FriendUser> friends = [];

  @override
  void initState() {
    super.initState();

    get_friends();

  }

  void get_friends() async {
    GetFriends getFriends = GetFriends();
    List<FriendUser> newList = [];

    newList = await getFriends.GetList();

    setState(() {

      friends = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var route = MaterialPageRoute(
            builder: (BuildContext context) => const Add_friend(),
          );
          Navigator.of(context).push(route);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFF374151),
        // remove the back button
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: const Color(0xFF111827),
        child: RefreshIndicator(
          onRefresh: () async {
            get_friends();
          },
          child: ListView(
              // backgroundColor: const Color(0xFF374151),

              children: friends
                  .map((friend) => UserFriend_widget(
                        username: friend.username,
                        lastMessage: "last message",
                        image: friend.image,
                      ))
                  .toList()),
        ),
      ),
    );
  }
}

// single user for list tile with parameters for username and last message and image

class UserFriend_widget extends StatelessWidget {
  final String? username;
  final String? lastMessage;
  final String? image;

  const UserFriend_widget(
      {Key? key,
      required this.username,
      required this.lastMessage,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // rounded leading image from assets
      leading: CircleAvatar(
        // almost transparent background
        backgroundColor: const Color(0xFF374151).withOpacity(0.2),

        backgroundImage: NetworkImage(image ?? ''),
        radius: 25,
      ),
      // leading: Image.asset('assets/authentication/profile_pic.png'),
      title: Text(username!, style: TextStyle(color: Colors.white)),
      subtitle: Text(lastMessage!, style: TextStyle(color: Colors.white)),
      onTap: () {

        GlobalStore globalStore = GlobalStore.getInstance();
        globalStore.local_storage.setItem("FriendUsername", username);

        var route = MaterialPageRoute(
          builder: (BuildContext context) => const MainChat(),
        );
        Navigator.of(context).push(route);
      },
    );
  }
}
