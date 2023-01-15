import 'package:chat_app/model/MongoDB/Operations.dart';

class GetMessages implements Operation{

  String username;

  GetMessages(this.username);

  @override
  Future<void> execute() {
    // TODO: implement execute
    throw UnimplementedError();
  }


}