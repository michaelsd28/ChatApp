import 'dart:typed_data';
import 'dart:io' show File, Platform;
import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/model/GetController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// import http package
import 'package:http/http.dart' as http;

class AudioPlayerWidget extends StatefulWidget {
  String audioID;

  AudioPlayerWidget({Key? key, required this.audioID}) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  double peekSeeker = 0;
  bool isPlaying = false;
  final player = AudioPlayer();
  double duration = 1;
  double position = 0;


  @override
  Widget build(BuildContext context) {
    // responsive container

    // size cannot be less than 300
    var width = MediaQuery.of(context).size.width * 0.6;

    return Container(
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                color: Colors.blueGrey,
                onPressed: () async {
                  if (isPlaying) {
                    await player.pause();
                    setState(() {
                      isPlaying = false;
                    });
                  } else {
                    String audioID = widget.audioID;
                    String audioURL = 'http://10.0.0.9:8080/get-file/$audioID';

                    Source playerSource = DeviceFileSource(audioURL);

                    if (Platform.isAndroid) {
                      http.Response response = await http.get(
                        Uri.parse(audioURL),
                      );
                      Uint8List bytes = response.bodyBytes;
                      playerSource = BytesSource(bytes);
                    }

                    await player.play(playerSource);

                    /// set the position of the audio file
                    player.onPositionChanged.listen((event) {
                      setState(() {
                        position = event.inSeconds.toDouble();
                      });
                    });

                    /// when the audio file is finished playing
                    player.onPlayerComplete.listen((event) {
                      setState(() {
                        isPlaying = false;
                      });
                    });

                    /// Get the duration of the audio file
                    player.onDurationChanged.listen((duration) {
                      setState(() {
                        this.duration = duration.inSeconds.toDouble();
                      });
                    });
                    setState(() {
                      isPlaying = true;
                    });
                  }
                },
                icon: isPlaying ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
              ),
              IconButton(
                color: Colors.deepOrangeAccent,
                onPressed: () async {
                  await player.stop();
                  setState(() {
                    isPlaying = false;
                    position = 0;
                  });
                },
                icon: const Icon(Icons.stop),
              ),
            ],
          ),
          Slider(
            // value: getController.seeker.value,
            // slider color
            activeColor: Colors.white,
            value: position,
            min: 0,
            max: duration,

            onChanged: (value) async {
              setState(() async {
                position = value;
                await player.seek(Duration(seconds: value.toInt()));
              });
            },
          ),
        ],
      ),
    );
  }
}

class PreviewAudioPlayerWidget extends StatefulWidget {
  const PreviewAudioPlayerWidget({Key? key}) : super(key: key);

  @override
  State<PreviewAudioPlayerWidget> createState() => _PreviewAudioPlayerWidgetState();
}

class _PreviewAudioPlayerWidgetState extends State<PreviewAudioPlayerWidget> {
  double peekSeeker = 0;
  bool isPlaying = false;
  final player = AudioPlayer();
  double duration = 1;
  double position = 0;
  GetController getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        children: [
          Row(
            /// place at the bottom
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              IconButton(
                color: Colors.blueGrey,
                onPressed: () async {
                  if (!isPlaying) {
                    String audioPath = 'assets/recordings/audio-recording.wav';

                    Source audioSource = DeviceFileSource(audioPath);

                    if (Platform.isAndroid) {
                      getController.currentAudioBytes = await File("/storage/emulated/0/Download/audio-recording-2.wav").readAsBytes();
                      audioSource = BytesSource(getController.currentAudioBytes);
                    }

                    await player.play(audioSource);

                    /// set the position of the audio file
                    player.onPositionChanged.listen((event) {
                      setState(() {
                        position = event.inSeconds.toDouble();
                      });
                    });

                    /// when the audio file is finished playing
                    player.onPlayerComplete.listen((event) {
                      setState(() {
                        isPlaying = false;
                      });
                    });

                    /// when the audio file is finished playing
                    player.onPlayerComplete.listen((event) {
                      setState(() {
                        isPlaying = false;
                        position = 0;
                      });
                    });

                    /// Get the duration of the audio file
                    player.onDurationChanged.listen((duration) {
                      setState(() {
                        this.duration = duration.inSeconds.toDouble();
                      });
                    });
                    setState(() {
                      isPlaying = true;
                    });
                  } else {
                    await player.pause();
                    setState(() {
                      isPlaying = false;
                    });
                  }
                },
                icon: isPlaying ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
              ),
              IconButton(
                color: Colors.deepOrangeAccent,
                onPressed: () async {
                  await player.stop();
                  setState(() {
                    isPlaying = false;
                    position = 0;
                  });
                },
                icon: const Icon(Icons.stop),
              ),
            ],
          ),
          Slider(
            // value: getController.seeker.value,
            // slider color
            activeColor: Colors.white,
            value: position,
            min: 0,
            max: duration,

            onChanged: (value) async {
              setState(() async {
                position = value;
                await player.seek(Duration(seconds: value.toInt()));
              });
            },
          ),
        ],
      ),
    );
  }
}
