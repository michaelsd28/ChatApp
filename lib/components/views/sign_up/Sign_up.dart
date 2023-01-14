/*

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
                        onPressed: () {},
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

 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sign_up extends StatelessWidget {
  const Sign_up({Key? key}) : super(key: key);

Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Container(
          color: const Color(0xff1f2937),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 80,
                    child: Text(
                      'User sign up',
                      style: TextStyle(
                        fontSize: 30,
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
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: TextField(
                            style: TextStyle(
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
                        // repeat password
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Repeat password',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF018BFF),
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text('Sign up'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ),
  );
}

}
