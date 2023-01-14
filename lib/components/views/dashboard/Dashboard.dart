import 'package:chat_app/components/views/chat/MainChat.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(


floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),

      appBar: AppBar(

        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFF374151),
      ),
      body: Container(
        color: const Color(0xFF111827),
        child: ListView(
          // backgroundColor: const Color(0xFF374151),

     children: List.generate(20, (index) {

            return ListTile(
              // rounded leading image from assets
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/authentication/profile_pic.png'),
                radius: 25,
              ),
              // leading: Image.asset('assets/authentication/profile_pic.png'),
              title: const Text('Username', style: TextStyle(color: Colors.white)),
              subtitle: const Text('Last text message', style: TextStyle(color: Colors.white)),
              onTap: () {
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) =>  MainChat(),
                );
                Navigator.of(context).push(route);
              },
            );
          }),

        ),
      ),
    );
  }
}
