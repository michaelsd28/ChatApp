package com.example.plugins

import com.google.gson.Gson
import io.ktor.application.*
import io.ktor.http.cio.websocket.*
import io.ktor.network.sockets.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.websocket.*
import java.time.*
import java.util.*
import java.util.concurrent.atomic.*

fun Application.configureSockets() {
    install(WebSockets) {
        pingPeriod = Duration.ofSeconds(15)
        timeout = Duration.ofSeconds(15)
        maxFrameSize = Long.MAX_VALUE
        masking = false
    }

    var count = 0

    routing {


        webSocket("/ws") { // websocketSession
            println("you are connected ${++count}")

            for (frame in incoming) {
                when (frame) {
                    is Frame.Text -> {
                        val text = frame.readText()
                        println("received: $text")

                        outgoing.send(Frame.Text("YOU SAID: $text"))
                        outgoing.send(Frame.Text("I SAID: ${text.toUpperCase()}"))
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

    }
}

class Connection(val session: DefaultWebSocketSession) {
    companion object {
        var lastId = AtomicInteger(0)
    }

    val name = "user${lastId.getAndIncrement()}"
}
