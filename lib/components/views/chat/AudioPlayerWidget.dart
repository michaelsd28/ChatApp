import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/GetController.dart';

class AudioPlayerWidget extends StatefulWidget {

  String audioID ;

   AudioPlayerWidget({Key? key,required this.audioID}) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  double peekSeeker = 0;
  bool isPlaying = false;
  final player = AudioPlayer();
  double duration = 1;
  double position = 0;
  final GetController getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    // responsive container

    return Row(
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
                  print("audioID:: $audioID");
                  var source = DeviceFileSource('http://localhost:8080/get-file/$audioID');
                  await player.play(source);

                  /// set the position of the audio file
                  player.onPositionChanged.listen((event) {
                    setState(() {
                      position = event.inSeconds.toDouble();
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
    );
  }
}
