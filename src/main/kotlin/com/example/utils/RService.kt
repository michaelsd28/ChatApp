package com.example.utils

import com.example.Database.RedisDB
import com.example.models.User
import com.google.gson.Gson

class RService {
    private val redisDB = RedisDB()

    fun getUser(id:String): User? {
        return try {
            Gson().fromJson(
                redisDB.connect().get(id),
                User::class.java
            )
        } catch (e: Exception) {
            println("error in database")
            null
        }
    }


}