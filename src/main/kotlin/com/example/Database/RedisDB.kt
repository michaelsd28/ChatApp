package com.example.Database

import com.example.models.FriendUser
import com.example.models.Message
import com.example.models.User
import com.google.gson.Gson
import redis.clients.jedis.Jedis
import java.util.*


class RedisDB {

    fun connect(): Jedis {
        val jedis = Jedis("localhost", 6379)
        jedis.select(1)
        return jedis
    }

    fun receiveMessage (message: Message){

        try {
            val sender:User =  Gson().fromJson(connect().get(message.MyUserID),User::class.java)
            val receiver:User =  Gson().fromJson(connect().get(message.userToID),User::class.java)

            sender.friends[0].messages= sender.friends[0].messages.plus(message)
            receiver.friends[0].messages= receiver.friends[0].messages.plus(message)

            connect().set(sender.id,Gson().toJson(sender))
            connect().set(receiver.id,Gson().toJson(receiver))
            println("messages updated in DB")

        } catch (e:Exception){
            println("an error occurred receiving Message")
        }



    }

    fun isUserID(id: String): Boolean {

        val check = connect().get(id)

        try {
            return !check.equals(null)
        } catch (e: Exception) {

            return false
        }


    }


}

fun main() {
    val db = RedisDB()

//    val id: UUID,
//    val name: String,
//    val password: String,
//    val userName: String,
//    val friends: List<UUID>,
//    val messages: List<Message>,
//    val groups: List<Group>,
//    val avatar: String,

//    val messages:Message = Message("001","Hola",User(),Date())

    val michael: User = User(
        "028",
        "michael",
        "123",
        "michaelsd28",
        emptyList(),
        emptyList(),
        emptyList(),
        "https://cdn-icons-png.flaticon.com/512/236/236832.png"
    )
    val ambar: User = User(
        "018",
        "ambar",
        "123",
        "ambarsd18",
        mutableListOf(),
        mutableListOf(),
        mutableListOf(),
        "https://cdn-icons-png.flaticon.com/512/2922/2922561.png"
    )
    val ambarFriendUser: FriendUser = FriendUser(
        "018",
        "ambar",
        "ambarsd18",
        emptyList(),
        "https://cdn-icons-png.flaticon.com/512/2922/2922561.png"
    )
    val michaelFriendUser: FriendUser = FriendUser(
        "028",
        "michael",
        "michaelsd18",
        emptyList(),
        "https://cdn-icons-png.flaticon.com/512/236/236832.png"

    )
    michael.addFriend(ambarFriendUser)
    ambar.addFriend(michaelFriendUser)

//    val userString = Gson().toJson(michael)

    val message: Message = Message(
        "001",
        "Hola",
        "028",
        Date(),
        "018"
    )
    val message3: Message = Message(
        "001",
        "Hola michael",
        "028",
        Date(),
        "028"
    )

    val michaelString = Gson().toJson(michael)
    val ambarString = Gson().toJson(ambar)
//    println(michaelString)
//    println(ambarString)
    db.connect().del("288")
    println(db.connect().get("288"))
}