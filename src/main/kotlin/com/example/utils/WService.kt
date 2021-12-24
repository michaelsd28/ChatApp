package com.example.utils

import com.example.models.Message
import com.google.gson.Gson
import io.ktor.http.cio.websocket.*

class WService {

    fun removeUser(map: MutableMap<String, WebSocketSession>, user: String) {
        map.remove(user)
    }


    suspend fun sendMessage(sessions: MutableMap<String, WebSocketSession>, text: String) {


        val messageString = text.replace("request-send ", "")
            val sendMessage: Message = Gson().fromJson(messageString, Message::class.java)
            sessions[sendMessage.userToID]?.send(Frame.Text(sendMessage.content))

    }

    suspend fun connectUser(sessions: MutableMap<String, WebSocketSession>, text: String,singleSession: WebSocketSession) {
        val id = text.split(" ")[1]
        sessions[id] = singleSession
        sessions[id]?.send(Frame.Text("Welcome to the server $id"))
        println("sessionsUser id: $id is active")
    }

}