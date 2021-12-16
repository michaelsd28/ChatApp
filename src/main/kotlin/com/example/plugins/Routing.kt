package com.example.plugins

import com.example.models.Response
import com.google.gson.Gson
import io.ktor.application.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.webjars.*
import java.io.File
import java.time.ZoneId

fun Application.configureRouting() {

    install(Webjars) {
        path = "/webjars" //defaults to /webjars
        zone = ZoneId.systemDefault() //defaults to ZoneId.systemDefault()
    }

    routing {
        get("/") {


//            respond html
            var file = File("src/main/resources/index.html")


            call.respondText  (file.readText(), ContentType.Text.Html)



        }

        post("/post") {

            call.respond(Gson().fromJson(call.receiveText(), Response::class.java))

        }



        get("/webjars") {
            call.respondText("<script src='/webjars/jquery/jquery.js'></script>", ContentType.Text.Html)
        }
    }
}
