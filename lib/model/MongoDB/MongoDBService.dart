import 'Operations.dart';


class MongoDBService implements Operation {
  Operation operation;

  MongoDBService(this.operation);

  @override
  Future<void> execute() async {
    // TODO: implement execute
   await operation.execute();
  }








}