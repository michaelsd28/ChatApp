package com.example

import io.ktor.server.application.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*
import com.example.plugins.*
import io.ktor.server.plugins.cors.routing.*
import routes.MainRoute

fun main() {

    embeddedServer(Netty, port = 8080, host = "0.0.0.0", module = Application::module)
        .start(wait = true)
}

//fun main() {
//    // railway listen to $PORT environment variable
//    embeddedServer(Netty, port = System.getenv("PORT")?.toInt() ?: 8080, host = "0.0.0.0") {
//        module()
//    }.start(wait = true)
//
//}


fun Application.module() {

    configureHTTP()
    configureSerialization()
    MainRoute()
}
