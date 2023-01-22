import 'package:flutter/material.dart';

import '../../../model/MongoDB/SignUp.dart';
import '../../../model/MongoDB/MongoDBService.dart';
import '../../../model/Classes/RegisterUser.dart';

class SignUp_widget extends StatefulWidget {
  const SignUp_widget({Key? key}) : super(key: key);

  @override
  State<SignUp_widget> createState() => _SignUp_widgetState();
}

class _SignUp_widgetState extends State<SignUp_widget> {

  var nameController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var userImageController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {





    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: Center(
        child: Container(
          color: const Color(0xff1f2937),
          child: Center(
            child: SingleChildScrollView(
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
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: TextField(

                              onChanged: (value) {
                             nameController.text = value;
                              },



                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: TextField(
                              onChanged: (value) {
                                usernameController.text = value;
                              },
                              style: const TextStyle(

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
                          // repeat password
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: TextFormField(
                              // The validator with the password above must match


                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
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
                            child: TextField(
                              onChanged: (value) {
                                userImageController.text = value;
                              },
                              controller: userImageController,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Image url',
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
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {


                                RegisterUser user = RegisterUser(
                                    name: nameController.text,
                                    username: usernameController.text,
                                    password: passwordController.text,
                                    userImage: userImageController.text);



                                SignUp insertUser = SignUp(user);
                                MongoDBService mongoDBService =
                                    MongoDBService(insertUser);

                                await mongoDBService.execute();
                              },
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
      ),
    );
  }
}
