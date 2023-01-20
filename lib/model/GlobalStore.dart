import 'package:localstorage/localstorage.dart';

class GlobalStore {


  LocalStorage local_storage = LocalStorage('GlobalStore_local');

  // public store to store data in the global store type Map<String, Object>
  Map<String, Object> storeMap = {};

  // gettter for the store
  Map<String, Object> get store => storeMap;




  static GlobalStore? _singleton;

  static GlobalStore getInstance() {
    _singleton ??= GlobalStore();
    return _singleton!;
  }
}
