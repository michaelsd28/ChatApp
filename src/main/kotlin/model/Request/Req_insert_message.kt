package model.Request

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



}