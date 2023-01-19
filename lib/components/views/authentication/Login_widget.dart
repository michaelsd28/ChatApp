import 'package:chat_app/components/views/dashboard/Dashboard.dart';
import 'package:chat_app/components/views/sign_up/SignUp_widget.dart';
import 'package:chat_app/model/GlobalStore.dart';
import 'package:chat_app/model/MongoDB/LoginUser.dart';
import 'package:chat_app/model/MongoDB/MongoDBService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../model/User.dart';

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
                        controller: passwordController,
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
                          onPressed: () async {
                            String username = usernameController.text;
                            String password = passwordController.text;
                            _login(context, username, password);
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
                                      const SignUp_widget(),
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

  void _login(BuildContext context, String username, String password) async {

    GlobalStore globalStore = GlobalStore.getInstance();
    globalStore.local_storage.setItem("FriendUsername", username);

    User user = User(username: username, password: password);

    LoginUser loginUser = LoginUser(user);
    MongoDBService mongoDBService = MongoDBService(loginUser);
    await mongoDBService.execute();
    GlobalStore store = GlobalStore.getInstance();

    String? jwt = store.local_storage.getItem("JWT_token");

    // print("Login_widget * jwt: $jwt");

    if (jwt != null) {
      // add code to navigate to the next screen (sign up)
      var route = MaterialPageRoute(
        builder: (BuildContext context) => const Dashboard(),
      );
      Navigator.of(context).push(route);
    } else if (jwt == null) {
      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username or password'),
        ),
      );

    }
  }
}
