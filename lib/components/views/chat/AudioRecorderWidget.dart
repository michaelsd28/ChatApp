import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
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
  final windowRecorder = Record();
  bool isRecording = false;
  FlutterSoundRecorder androidRecorder = FlutterSoundRecorder();
  String pathToAudio = "";
  Uint8List androidAudioFileBytes = Uint8List(0);

  bool _playAudio = false;
  String _timerText = '00:00:00';

  GetController getController = Get.put(GetController());

  @override
  void initState() {
    super.initState();
  }

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
            if (!isRecording) {
              /// Check and request permission
              // current date and time with the format: yyyy-MM-dd HH-mm-ss
              String timeNow = DateTime.now().toString().replaceAll(":", "-").replaceAll(".", "-");

              String assetPath = 'assets/recordings/audio-recording.wav';

              // bool hasPermission = await record.hasPermission();

              if (Platform.isAndroid) {
                /// use media recorder native android

                // Request Microphone permission if needed
                PermissionStatus status = await Permission.microphone.request();
                if (status != PermissionStatus.granted) throw RecordingPermissionException("Microphone permission not granted");
                await androidRecorder.openRecorder();

                // sdcard download folder
                String androidPath = "/storage/emulated/0/Download/audio-recording-2.wav";

                await androidRecorder.startRecorder(toFile: androidPath, codec: Codec.defaultCodec);

                ///  convert audio file to uint8list
                androidAudioFileBytes = await File(androidPath).readAsBytes();
              } else if (Platform.isWindows) {
                await windowRecorder.start(path: assetPath, encoder: AudioEncoder.wav, bitRate: 128000, samplingRate: 44100);

              }

              setState(() {
                isRecording = true;
              });
            } else {
              await windowRecorder.stop();
              await androidRecorder.closeRecorder();

              /// lister to web recorder and on data available doesnt work

              setState(() {
                isRecording = false;
              });

              // getController.currentAudioBytes = await File("/storage/emulated/0/Download/audio-recording-2.wav").readAsBytes();
              // Source source = BytesSource(androidAudioFileBytes);
              // AudioPlayer audioPlayer = AudioPlayer();
              // audioPlayer.setSource(source);
              // audioPlayer.play(source);

              previewDialog();
            }
          },
        ),
      ],
    );
  }

  void previewDialog() {
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
  }
}
