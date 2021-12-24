package com.example.plugins

import com.example.Database.RedisDB
import com.example.models.Message
import com.example.utils.MessageUtil
import com.example.utils.WService
import com.google.gson.Gson
import io.ktor.application.*
import io.ktor.http.cio.websocket.*
import io.ktor.routing.*
import io.ktor.websocket.*
import java.time.Duration
import java.util.*

fun Application.configureSockets() {
    install(WebSockets) {
        pingPeriod = Duration.ofSeconds(15)
        timeout = Duration.ofSeconds(15)
        maxFrameSize = Long.MAX_VALUE
        masking = false
    }

    val redisDB: RedisDB = RedisDB()
    val messageUtil: MessageUtil = MessageUtil()
    val WService: WService = WService()

    var count = 0

    routing {

        //5 max size

        val sessions = mutableMapOf<String, WebSocketSession>()
//        val loco:String = sessions
        webSocket("/ws") { // websocketSession
            println("you are connected ${++count}")


            val sessionId = UUID.randomUUID().toString()
            sessions[sessionId] = this
            sessions[sessionId]?.send(Frame.Text("Welcome to the server $sessionId"))


            for (frame in incoming) {
                when (frame) {
                    is Frame.Text -> {
                        val text = frame.readText()
                        println("received: $text")
                        val id = text.split(" ")[1]

                        if (text.contains("disconnect")) {
                            sessions.remove(id)
                            println("removed $id")
                        }


                        sessions.values.forEach {
                            if (sessions[id] != it) {
                                it.send(Frame.Text("$id  $text"))
                            }
                        }


//                        outgoing.send(Frame.Text("YOU SAID: $text"))

                        if (text.equals("bye", ignoreCase = true)) {
                            close(CloseReason(CloseReason.Codes.NORMAL, "Client said BYE"))
                        }
                    }
                    else -> {}
                }
            }


        } // end of websocketsSession


        val sessionsUser = mutableMapOf<String, WebSocketSession>()
        webSocket("/send") { // websocketsSession
            // println("you are connected ${++count}")

            val sessionId = UUID.randomUUID().toString()
            sessionsUser[sessionId] = this


            for (frame in incoming) {
                when (frame) {
                    is Frame.Text -> {
                        val text = frame.readText()
                        println("received: $text")

                        if (text.contains("id-Client")) {
                            WService.connectUser(sessionsUser, text,this)
                        }

                        if (text.contains("request-send")) {
                         WService.sendMessage(sessionsUser, text)
                        }

                        if (text.contains("disconnect")) {
                            WService.removeUser(sessionsUser, text.split(" ")[1])
                        }



                    }
                    else -> {}
                }
            }

        } // end of websocketsSession


    }
}

