

import 'package:localstorage/localstorage.dart';

class GlobalStore   {

  static final _store = <String, Object>{};

    LocalStorage local_storage =  LocalStorage('GlobalStore_local');


  static  GlobalStore? _singleton;



  static GlobalStore getInstance() {


    _singleton ??= GlobalStore();
    return _singleton!;
  }



}