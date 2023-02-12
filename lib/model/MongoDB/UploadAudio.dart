import 'dart:io';

import 'package:chat_app/model/GetController.dart';
import 'package:chat_app/model/MongoDB/Operations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// import media type
import 'package:http_parser/http_parser.dart';

// import http package
import 'package:http/http.dart' as http;

class UploadAudio implements Operation {
  GetController getController = Get.put(GetController());

  @override
  Future<void> execute() async {
    var uri = Uri.parse('http://10.0.0.9:8080/save-file');

    var request = http.MultipartRequest('POST', uri);

    //assets/recordings/audio-recording.wav

    String filePath = 'assets/recordings/audio-recording.wav';



    if(Platform.isWindows) {
      request.files.add(await http.MultipartFile.fromPath('file', filePath, contentType: MediaType('audio', 'wav')));
    }


    if (Platform.isAndroid) {
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        getController.currentAudioBytes!,
        filename: 'audio.wav',
        contentType: MediaType('audio', 'wav'),
      ));
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var audioID = await response.stream.bytesToString();
      getController.currentAudioID = audioID;
      print("UploadAudio:: * audioID: $audioID");
      // 63e75b5103e64a495bb27981

    } else {
      print(response.reasonPhrase);
    }
  }
}
