package routes

import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Application.Message() {

    // Message route
    routing{
        get ("/message") {
            call.respondText("Message")
        }

    }



}