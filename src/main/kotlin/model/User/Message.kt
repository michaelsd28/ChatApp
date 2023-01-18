package model.User

import model.Request.Req_insert_message

class Message {


    var sender: String = ""
    var receiver: String = ""
    var message: String = ""
    var timestamp: String = ""
    var type: String = ""

    /* json format
    {
        "sender": "sender",
        "receiver": "receiver",
        "message": "message",
        "timestamp": "timestamp",
        "type": "type"
    }
    */


    fun fromRequest(reqAddMessage: Req_insert_message): Message {
        var message = Message()
        message.sender = reqAddMessage.sender
        message.receiver = reqAddMessage.receiver
        message.message = reqAddMessage.message
        message.timestamp = reqAddMessage.time
        message.type = reqAddMessage.type
        return message


    }


}