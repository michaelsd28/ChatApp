import 'dart:io';

import 'package:localstorage/localstorage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GlobalStore {
  LocalStorage local_storage = LocalStorage('GlobalStore_local');

  // public store to store data in the global store type Map<String, Object>
  Map<String, Object> storeMap = {};

  // gettter for the store
  Map<String, Object> get store => storeMap;

  // do the same with websockets

   WebSocketChannel? _channel;

   WebSocketChannel? GetChannel() {
// channel with broadcast to listen to the same channel from different places
    String connectionString = "ws://10.0.0.174:8080/chat-server";

    _channel ??= WebSocketChannel.connect(
      Uri.parse(connectionString),
    );
    return _channel!;
  }




  static GlobalStore? _singleton;

  static GlobalStore getInstance() {
    _singleton ??= GlobalStore();
    return _singleton!;
  }
}
