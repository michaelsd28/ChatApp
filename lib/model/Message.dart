class Message {

  String? sender;
  String? receiver;
  String? message;
  String? timestamp;
  String? type;

  Message({
    this.sender,
    this.receiver,
    this.message,
    this.timestamp,
    this.type,
  });

  static Message fromJson(message) {

    return Message(
      sender: message['sender'],
      receiver: message['receiver'],
      message: message['message'],
      timestamp: message['timestamp'],
      type: message['type'],
    );


  }
}
