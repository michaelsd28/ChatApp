package com.example.plugins

import com.example.Database.RedisDB
import com.example.models.Message
import com.example.utils.MessageUtil
import com.google.gson.Gson
import io.ktor.application.*
import io.ktor.http.cio.websocket.*
import io.ktor.request.*
import io.ktor.routing.*
import io.ktor.websocket.*
import kotlinx.coroutines.isActive
import java.time.Duration
import java.util.*
import java.util.concurrent.atomic.AtomicInteger

fun Application.configureSockets() {
    install(WebSockets) {
        pingPeriod = Duration.ofSeconds(15)
        timeout = Duration.ofSeconds(15)
        maxFrameSize = Long.MAX_VALUE
        masking = false
    }

    val redisDB:RedisDB = RedisDB()


    val messageUtil:MessageUtil = MessageUtil()

    var count = 0

    routing {

        //5 max size

        val sessions = mutableMapOf<String, WebSocketSession>()
//        val loco:String = sessions
        webSocket("/ws") { // websocketSession
            println("you are connected ${++count}")



            val token = call.parameters["token"]
            println("token: $token")


            val sessionId = UUID.randomUUID().toString()
            sessions[sessionId] = this
            sessions[sessionId]?.send(Frame.Text("Welcome to the server $sessionId"))


            for (frame in incoming) {
                when (frame) {
                    is Frame.Text -> {
                        val text = frame.readText()
                        println("received: $text")
                        val id = text.split(" ")[1]
//51717aa8-591e-48df-91d5-9a978e749e7a
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


        val connections = Collections.synchronizedSet<Connection?>(LinkedHashSet())
        webSocket("/multiple") {        // websockets multiple connections

            val thisConnection = Connection(this)

            connections += thisConnection
            send("You've logged in as [${thisConnection.name}] ")


            for (frame in incoming) {
                when (frame) {
                    is Frame.Text -> {
                        val receivedText = frame.readText()
                        println("received: $receivedText  from ${thisConnection.name}")
                        val textWithUsername = "[${thisConnection}]: $receivedText"
//                        outgoing.send(Frame.Text(textWithUsername))
                        connections.forEach {

                            it.session.send(Frame.Text("received a text1: $receivedText from [${thisConnection.name}]"))
                            it.session.outgoing.send(Frame.Text("received a text2: $receivedText from [${thisConnection.name}]"))

                            println("sending to ${it.name}")
                        }
                    }
                    else -> {
//                        println("received $frame of type ${frame::class}")
                    }
                }
            }
        }


        val sessionsUser = mutableMapOf<String, WebSocketSession>()
        webSocket("/send") { // websocketSession
            println("you are connected ${++count}")

            val sessionId = UUID.randomUUID().toString()
            sessionsUser[sessionId] = this
            sessionsUser[sessionId]?.send(Frame.Text("Welcome to the server $sessionId"))






            for (frame in incoming) {
                when (frame) {
                    is Frame.Text -> {
                        val text = frame.readText()
                        println("received: $text")

                        if (text.contains("id-Client")) {
                            val id = text.split(" ")[1]
                            sessionsUser[id] = this
                            println( "sessionsUser id: $id is active")
                        }

                        if (text.contains("request-send")) {
                            val messageString = text.replace("request-send ", "")
                            println("$messageString ***messageString*** " )

                                val sendMessage:Message = Gson().fromJson(messageString, Message::class.java)
                            println(sendMessage.toString())
                            sessionsUser[sendMessage.userToID]?.send(Frame.Text(sendMessage.content))
                        }












//                        try {
//                            val message = Gson().fromJson(text, Message::class.java)
//                            redisDB.receiveMessage(message)
//                            println("received a valid message: $message")
//                        } catch (e: Exception) {
//                            e.printStackTrace()
//                        }





                        if (text.equals("bye", ignoreCase = true)) {
                            close(CloseReason(CloseReason.Codes.NORMAL, "Client said BYE"))
                        }
                    }
                    else -> {}
                }
            }


        } // end of websocketsSession

    }
}

class Connection(val session: DefaultWebSocketSession) {
    companion object {
        var lastId = AtomicInteger(0)
    }

    val name = "user${lastId.getAndIncrement()}"
}
