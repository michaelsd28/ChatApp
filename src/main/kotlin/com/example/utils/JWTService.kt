package com.example.utils

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import com.example.models.User
import com.google.gson.Gson
import java.util.*


class JWTService {

    private val secret: String = "secret"
    private val algorithmJWT = Algorithm.HMAC256("secret3")


    fun decodeJWT(token: String): String {

        return try {
            JWT.require(algorithmJWT)
                .build()
                .verify(token).getClaim("Data").toString()

        } catch (exception: Exception) {
            //Invalid token

            "${exception.message}"
        }
    }

    fun validateToken(token: String): String {
        return try {
            JWT.require(algorithmJWT)
                .build()
                .verify(token).toString()
        } catch (exception: Exception) {
            //Invalid token
            "${exception.message}"
        }

    }


    fun createJWT(user: String): String {

        /* 7 days*/
        val date = Date(System.currentTimeMillis() + 604800000)

        return JWT.create()
            .withClaim("Data", user)
            .withExpiresAt(date)
            .sign(algorithmJWT)
    }
}

fun main() {
    val jwtService = JWTService()
    val json = "{\\\"id\\\":\\\"028\\\",\\\"name\\\":\\\"michael\\\",\\\"password\\\":\\\"123\\\",\\\"userName\\\":\\\"michaelsd28\\\",\\\"friends\\\":[{\\\"id\\\":\\\"018\\\",\\\"name\\\":\\\"ambar\\\",\\\"userName\\\":\\\"ambarsd18\\\",\\\"messages\\\":[],\\\"avatar\\\":\\\"https://cdn-icons-png.flaticon.com/512/2922/2922561.png\\\"}],\\\"messages\\\":[],\\\"groups\\\":[],\\\"avatar\\\":\\\"https://cdn-icons-png.flaticon.com/512/236/236832.png\\\"}"
    val jwt =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJEYXRhIjoie2lkOjAyOCxuYW1lOm1pY2hhZWwscGFzc3dvcmQ6MTIzLHVzZXJOYW1lOm1pY2hhZWxzZDI4LGZyaWVuZHM6W3tpZDowMTgsbmFtZTphbWJhcix1c2VyTmFtZTphbWJhcnNkMTgsbWVzc2FnZXM6W10sYXZhdGFyOmh0dHBzOi8vY2RuLWljb25zLXBuZy5mbGF0aWNvbi5jb20vNTEyLzI5MjIvMjkyMjU2MS5wbmd9XSxtZXNzYWdlczpbXSxncm91cHM6W10sYXZhdGFyOmh0dHBzOi8vY2RuLWljb25zLXBuZy5mbGF0aWNvbi5jb20vNTEyLzIzNi8yMzY4MzIucG5nfSIsImV4cCI6MTY0MTAxNDQ0NH0.kyTW0gwBGwxFjuE7o6lV1Z_c8QeVKjsGFagwl3TV-GE"
    val token = jwtService.createJWT(json)
    var json1 = jwtService.decodeJWT(token)
    json1 = json1.substring(1, json1.length - 1).replace("\\", "")
    val user:User = Gson().fromJson(json1, User::class.java)

    println(json1)
}