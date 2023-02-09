package model.Request

import com.google.gson.Gson

class WebSocketLogin {
    var username: String = ""
    var token: String = ""

    companion object {
        fun fromString(message: String): WebSocketLogin {

            return try {
                var webSocketLogin = WebSocketLogin()
                val gson = Gson()
                val classType = WebSocketLogin::class.java
                webSocketLogin = gson.fromJson(message, classType)
                webSocketLogin


            } catch (e: Exception) {

                WebSocketLogin()
            }


        }

    }
}