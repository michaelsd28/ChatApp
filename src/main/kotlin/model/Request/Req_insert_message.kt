package model.Request

import model.User.Message

class Req_insert_message {
    var token: String = ""
    var message: String = ""
    var type: String = ""
    var receiver: String = ""
    var sender: String = ""
    var time: String = ""

    /* json format
    {
        "token": "token",
        "message": "message",
        "type": "type",
        "receiver": "receiver",
        "sender": "sender",
        "time": "time"
    }
    */

    override fun toString(): String {
        return "Req_insert_message(token='$token', message='$message', type='$type', receiver='$receiver', sender='$sender', time='$time')"
    }

    fun fromMessage(messageObj: Message): Req_insert_message {

        var reqMessage = Req_insert_message()
        reqMessage.sender = messageObj.sender
        reqMessage.receiver = messageObj.receiver
        reqMessage.message = messageObj.message
        reqMessage.time = messageObj.timestamp
        reqMessage.type = messageObj.type
        return reqMessage


    }


}