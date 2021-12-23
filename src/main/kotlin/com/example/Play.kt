package com.example

import com.example.models.Message
import com.example.models.Response
import com.example.utils.MessageUtil
import com.google.gson.Gson
import java.io.File
import java.util.*

class Play {
}

fun main() {
    val mesageutil: MessageUtil = MessageUtil()

    val message:Message = Message(
        "001",
        "Hello Kotlin", "028",
        Date(),
        "018",
    )

    val string = "{\"id\":\"Hello World\",\"content\":\"Hello Kotlin\",\"MyUserID\":\"Hello World\",\"date\":\"Dec 22, 2021, 3:49:11 AM\",\"userToID\":\"Hello World\"}"


    val message2:Message = Gson().fromJson(string, Message::class.java)
    println(Gson().toJson(message))
}