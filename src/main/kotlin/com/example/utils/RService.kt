package com.example.utils

import com.example.Database.RedisDB
import com.example.models.User
import com.google.gson.Gson
import java.io.ByteArrayOutputStream
import java.io.IOException
import java.net.URL

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

    fun downloadUrl(toDownload: URL): ByteArray? {
        val outputStream = ByteArrayOutputStream()
        try {
            val chunk = ByteArray(98304)
            var bytesRead: Int
            val stream = toDownload.openStream()
            while (stream.read(chunk).also { bytesRead = it } > 0) {
                outputStream.write(chunk, 0, bytesRead)
            }
        } catch (e: IOException) {
            e.printStackTrace()
            return null
        }
        return outputStream.toByteArray()
    }


}