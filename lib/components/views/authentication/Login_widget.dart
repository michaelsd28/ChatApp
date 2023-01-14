import 'package:chat_app/components/views/dashboard/Dashboard.dart';
import 'package:chat_app/components/views/sign_up/Sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login_widget extends StatelessWidget {
  const Login_widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
// tailwind color palette dark mode
// max width 400

      color: Color(0xff1f2937),
      child: Center(
        // add text and  align the text to the center of the screen (horizontally and vertically)
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            // spaceEvenly centers the text vertically
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
                child: Text(
                  'User login',
                  style: TextStyle(
                    fontSize: 30,
                    // color hex code
                    color: Color(0xFF018BFF),
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: TextField(
                        style: TextStyle(
                          // text color is white and placeholder color is gray
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),

                    const TextField(
                      // padding top
                      style: TextStyle(
                        color: Colors.white,
                      ),

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    // button that takes all the space available

                    Padding(
                      // padding top only
                      padding: const EdgeInsets.only(top: 16.0),
                      child: ElevatedButton(
                        // rounded corners

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF018BFF),
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // add code to navigate to the next screen (sign up)
                          var route = MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Dashboard(),
                          );
                          Navigator.of(context).push(route);

                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
