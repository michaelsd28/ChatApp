import 'package:chat_app/model/GetController.dart';
import 'package:chat_app/model/MongoDB/Operations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// import http package
import 'package:http/http.dart' as http;

class UploadAudio implements Operation {


  GetController getController = Get.put(GetController());

  @override
  Future<void> execute() async {

    var filePath = 'assets/recordings/audio-recording.wav';
    var uri = Uri.parse('http://localhost:8080/save-file');

    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      var audioID = await response.stream.bytesToString();
      getController.currentAudioID = audioID;
      print("UploadAudio:: * audioID: $audioID");

    } else {
      print(response.reasonPhrase);
    }
  }
}
