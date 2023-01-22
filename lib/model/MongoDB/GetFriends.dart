import 'dart:convert';

import 'package:chat_app/model/GlobalStore.dart';
import 'package:chat_app/model/MongoDB/Operations.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

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
    var request = http.Request('GET', Uri.parse(requestUrl));
    var headers = {'Content-Type': 'application/json'};

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
