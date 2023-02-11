import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:record/record.dart';

import '../../../model/Classes/Message.dart';
import '../../../model/GetController.dart';
import '../../../model/MongoDB/UploadAudio.dart';
import 'AudioPlayerWidget.dart';

class AudioRecorderWidget extends StatefulWidget {
  const AudioRecorderWidget({Key? key}) : super(key: key);

  @override
  State<AudioRecorderWidget> createState() => _RecorderWidgetState();
}

class _RecorderWidgetState extends State<AudioRecorderWidget> {
  final record = Record();
  bool isRecording = false;

  GetController getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: isRecording
              ? const Icon(
                  Icons.stop,
                  color: Colors.redAccent,
                )
              : const Icon(Icons.mic, color: Colors.white70),
          onPressed: () async {
            if (isRecording) {
              await record.stop();

              /// open alert dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    // color 141e32
                    backgroundColor: const Color(0xff1c2834),
                    title: const Text(
                      "Upload Audio",
                      style: TextStyle(color: Colors.white70),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Do you want to upload this audio?",
                          style: TextStyle(color: Colors.white70),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.only(top: 10),
                          decoration: const BoxDecoration(
                            color: Color(0xff252b30),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const PreviewAudioPlayerWidget(),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () async {
                          UploadAudio uploadAudio = UploadAudio();
                          await uploadAudio.execute();

                          var myUsername = getController.myUsername;
                          var FriendUsername = getController.FriendUsername;
                          var currentAudioID = getController.currentAudioID;

                          // add message to the list
                          var messageJson = {
                            "sender": myUsername,
                            "receiver": FriendUsername,
                            "message": currentAudioID,
                            "timestamp": DateTime.now().toString(),
                            "type": "audio"
                          };
                          Message message = Message.fromJson(messageJson);

                          getController.sendMessage(jsonEncode(messageJson));
                          getController.myMessages.add(message);

                          /// scroll to bottom of the list
                          getController.scrollController.animateTo(
                            getController.scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );

                          Navigator.of(context).pop();
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  );
                },
              );

              // UploadAudio uploadAudio = UploadAudio();
              // await uploadAudio.execute();

              setState(() {
                isRecording = false;
              });
            } else {
              /// Check and request permission
              // current date and time with the format: yyyy-MM-dd HH-mm-ss
              String timeNow = DateTime.now().toString().replaceAll(":", "-").replaceAll(".", "-");

              String path = 'assets/recordings/audio-recording.wav';

              if (await record.hasPermission()) {
                // Start recording
                await record.start(path: path, encoder: AudioEncoder.wav, bitRate: 128000, samplingRate: 44100);
              }
              setState(() {
                isRecording = true;
              });
            }
          },
        ),
      ],
    );
  }
}
