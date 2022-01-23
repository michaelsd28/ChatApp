package com.example

import com.example.plugins.configureRouting
import com.example.plugins.configureSerialization
import com.example.plugins.configureSockets
import io.ktor.server.engine.*
import io.ktor.server.netty.*
import java.awt.Desktop

fun main() {

//heroku config
//        embeddedServer(Netty, port = System.getenv("PORT").toInt()) {
    embeddedServer(Netty, port = 8080, host = "0.0.0.0") {

        configureRouting()
        configureSerialization()
        configureSockets()

        Desktop.getDesktop().browse(java.net.URI("http://localhost:8080/"))

//        Runtime.getRuntime().exec("wsl Ubuntu-20.04-copy redis-server")

    }.start(wait = true)
}
