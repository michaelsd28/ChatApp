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
                                    minimumSize: Size(50, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'G',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              // github button
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    minimumSize: Size(50, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'G',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              // facebook button
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  minimumSize: Size(50, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'F',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
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
    );
  }
}
