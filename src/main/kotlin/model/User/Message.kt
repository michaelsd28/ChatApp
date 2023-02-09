package model.User

import com.google.gson.Gson
import model.Request.Req_insert_message

class Message() {


    var sender: String = ""
    var receiver: String = ""
    var message: String = ""
    var timestamp: String = ""
    var type: String = ""

    /*

    create sql table
    CREATE TABLE IF NOT EXISTS Messages (sender VARCHAR(255), receiver VARCHAR(255), message VARCHAR(255), timestamp VARCHAR(255), type VARCHAR(255))



   */


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
        val message = Message()
        message.sender = reqAddMessage.sender
        message.receiver = reqAddMessage.receiver
        message.message = reqAddMessage.message
        message.timestamp = reqAddMessage.time
        message.type = reqAddMessage.type
        return message


    }

    companion object {

        fun fromString(message: String): Message? {


            val gson = Gson()
            val classType = Message::class.java

            val messageObj: Message?

            return try {
                messageObj = gson.fromJson(message, classType)
                messageObj
            } catch (e: Exception) {
                null
            }


        }

    }


}