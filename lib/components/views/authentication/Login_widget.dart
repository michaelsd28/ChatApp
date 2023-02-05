import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/components/views/dashboard/Dashboard.dart';
import 'package:chat_app/components/views/sign_up/SignUp_widget.dart';
import 'package:chat_app/model/GlobalStore.dart';
import 'package:chat_app/model/MongoDB/LoginUser.dart';
import 'package:chat_app/model/MongoDB/MongoDBService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../model/Classes/User.dart';
import '../../../model/GetController.dart';

class Login_widget extends StatefulWidget {
  const Login_widget({Key? key}) : super(key: key);

  @override
  State<Login_widget> createState() => _Login_widgetState();
}

class _Login_widgetState extends State<Login_widget> {
  double peekSeeker = 0;
  final player = AudioPlayer();
  double duration =  1;
  final GetController getController = Get.put(GetController());
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      Text("Seeker: $peekSeeker"),
                      Slider(
                        value: peekSeeker,
                        onChangeStart: (value) async {
                          await player.pause();
                          // get duration of the audio file and set it to the max value of the slider



                        },
                        onChanged: (value) {
                          setState(() async {
                            peekSeeker = value;

                          });
                        },
                        onChangeEnd: (value) async {
                          await player.seek(Duration(seconds: value.toInt()));
                          await player.resume();
                        },
                        min: 0,
                        max: duration.toDouble(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        // text needs to be white
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
                            Obx(
                              () => Container(
                                decoration: const BoxDecoration(),
                                child: Center(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xff0f0f0f),
                                      foregroundColor: Colors.white,
                                      minimumSize: const Size(50, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () async {

                                      player.onDurationChanged.listen((duration) {
                                        setState(() {
                                          this.duration = duration.inSeconds.toDouble();
                                        });
                                      });




                                      player.onPlayerStateChanged.listen((state) {
                                        if (state == PlayerState.completed) {
                                          setState(() {
                                            getController.isPlaying.value = false;
                                          });
                                        }
                                      });

                                      // player  set position to 5 seconds

                                      player.onPositionChanged.listen((position) {
                                        setState(() {
                                          peekSeeker = position.inSeconds.toDouble();
                                        });
                                      });

                                      if (getController.isPlaying.value == true) {
                                        await player.stop();

                                        getController.isPlaying.value = false;
                                        return;
                                      } else {
                                        await player.play(DeviceFileSource("assets/chat/audio-sample2.mp3")); // will immediately start playing

                                        getController.isPlaying.value = true;
                                      }

                                    },
                                    child: getController.isPlaying.value == false ? const Text('▶️') : const Text('⏸️'),
                                  ),
                                ),
                              ),
                            ),
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
                              'Dont have an account?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // add code to navigate to the next screen (sign up)
                                var route = MaterialPageRoute(
                                  builder: (BuildContext context) => const SignUp_widget(),
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
    globalStore.local_storage.setItem("MyUsername", username);

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
          content: Text('Credenciales incorrectas'),
        ),
      );
    }
  }
}
