import 'dart:convert';

import 'package:chat_app/model/GlobalStore.dart';
import 'package:chat_app/model/MongoDB/Operations.dart';
import 'package:http/http.dart' as http;

import '../Classes/FriendUser.dart';

class GetFriends implements Operation {
  // List<FriendUser> friends = [];
  //
  // GetFriends(friends);

  Future<List<FriendUser>> GetList() async {
    List<FriendUser> friends = [];

    GlobalStore globalStore = GlobalStore.getInstance();
    String? token = globalStore.local_storage.getItem("JWT_token");
    String requestUrl = "http://10.0.0.9:8080/get-friends/$token";
    var uri = Uri.parse(requestUrl);
    var request = http.Request('GET', uri);
    var headers = {'Content-Type': 'application/json' , 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE', 'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept, Authorization'};

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String body = await response.stream.bytesToString();

    print(
        "response status code: ${response.statusCode} * response body: ${body}");

    if (response.statusCode == 200) {
      List<dynamic> list = jsonDecode(body);
      for (var element in list) {
        FriendUser newFriend = FriendUser();
        newFriend.name = element["name"];
        newFriend.username = element["username"];
        newFriend.image = element["image"];
        friends.add(newFriend);
      }
    }
    return friends;
  }

  @override
  Future<void> execute() {
    // TODO: implement execute
    throw UnimplementedError();
  }
}
