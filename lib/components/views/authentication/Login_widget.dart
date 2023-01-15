import 'package:chat_app/components/views/dashboard/Dashboard.dart';
import 'package:chat_app/components/views/sign_up/Sign_up.dart';
import 'package:chat_app/model/MongoDB/MongoDBService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/MongoDB/FindUser.dart';

class Login_widget extends StatelessWidget {
  const Login_widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var usernameController = TextEditingController();
    var passwordController = TextEditingController();


    return Container(

      // tailwind color palette dark mode
      // max width 400

      color: const Color(0xff1f2937),
      child: Center(
        // add text and  align the text to the center of the screen (horizontally and vertically)
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
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
                       Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          controller: usernameController,
                          onChanged: (value) {
                            usernameController.text = value;
                          },
                          style: const TextStyle(
                            // text color is white and placeholder color is gray
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),

                       TextField(
                        onChanged: (value) {
                          passwordController.text = value;
                        },
                        controller:  passwordController,
                        // padding top
                        style: const TextStyle(
                          color: Colors.white,
                        ),

                        decoration: const InputDecoration(
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
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {

                            var username = usernameController.text;
                            var password = passwordController.text;

                            FindUser findUser = FindUser();
                            MongoDBService mongoDBService = MongoDBService(findUser);

                            if (username == 'admin' && password == 'admin') {
                              // add code to navigate to the next screen (sign up)
                              var route = MaterialPageRoute(


                                builder: (BuildContext context) =>
                                const Dashboard(),
                              );
                              Navigator.of(context).push(route);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUp(),
                                ),
                              );
                            }




                          },
                          child: const Text('Login'),
                        ),
                      ),
                      // or login with google button or github button or facebook button or sign up button
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Or login with',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                // google button
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      minimumSize: const Size(50, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Image.asset(
                                      'assets/authentication/google_logo.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ),
                                // github button
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      minimumSize: const Size(50, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Image.asset(
                                      'assets/authentication/github_logo.png',
                                      width: 20,
                                      height: 20,
                                    ),

                                  ),
                                ),
                                // facebook button
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    minimumSize: const Size(50, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Image.asset(
                                    'assets/authentication/facebook_logo.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // sign up button
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // add code to navigate to the next screen (sign up)
                                var route = MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Sign_up(),
                                );
                                Navigator.of(context).push(route);
                              },
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // i love github copilot - thank you microsoft for this amazing tool

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
