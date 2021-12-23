package com.example

import com.example.plugins.configureRouting
import com.example.plugins.configureSerialization
import com.example.plugins.configureSockets
import io.ktor.server.engine.*
import io.ktor.server.netty.*
import java.awt.Desktop

fun main() {

    embeddedServer(Netty, port = 8080, host = "0.0.0.0") {

        configureRouting()
        configureSerialization()
        configureSockets()

        Desktop.getDesktop().browse(java.net.URI("http://localhost:8080/"))

    }.start(wait = true)
}
