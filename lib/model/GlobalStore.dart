import 'package:mongo_dart/mongo_dart.dart';

class GlobalStore   {

  static final _store = <String, Object>{};
  static Db mongoDB = Db("mongodb://10.0.0.9:6082/ChatDB");





  static  GlobalStore? _singleton;

  static GlobalStore getInstance() {

    _store["mongoDB"] = mongoDB;
    _singleton ??= GlobalStore();
    return _singleton!;
  }



}