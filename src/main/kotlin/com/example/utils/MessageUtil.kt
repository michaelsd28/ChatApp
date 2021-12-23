package com.example.utils

import com.example.models.Message
import com.example.models.User
import com.google.gson.Gson

class MessageUtil {


    fun isValidUser(user:String):Boolean{
        try {
            Gson().fromJson(user,User::class.java)
            return true
        } catch (e:Exception){

            e.printStackTrace()
            return false
        }
    }

    fun isValidMessage(message:String):Boolean{
        try {
            Gson().toJson(message::class.java)
            return true
        } catch (e:Exception){
            e.printStackTrace()
            return false
        }

    }
}


fun main() {
    val check:MessageUtil = MessageUtil()

    val test :User = User(
        "018",
        "ambar",
        "123",
        "ambarsd18",
        mutableListOf(),
        mutableListOf(),
        mutableListOf(),
        "https://cdn-icons-png.flaticon.com/512/2922/2922561.png"
    )

    val string:String = Gson().toJson(test)

    println(check.isValidUser(string))

}