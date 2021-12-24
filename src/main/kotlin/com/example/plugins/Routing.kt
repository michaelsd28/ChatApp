package com.example.plugins

import com.example.Database.RedisDB
import com.example.models.Message
import com.example.models.Response
import com.example.models.User
import com.example.utils.RService
import com.google.gson.Gson
import io.ktor.application.*
import io.ktor.features.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.webjars.*
import java.io.File
import java.time.ZoneId

fun Application.configureRouting() {
    install(CORS) {
//        allow all
        anyHost()
    }


    val redisDB = RedisDB()
    val RService = RService()

    install(Webjars) {
        path = "/webjars" //defaults to /webjars
        zone = ZoneId.systemDefault() //defaults to ZoneId.systemDefault()
    }

    routing {
        get("/") {

//            respond html
            val file = File("src/main/resources/index.html")

            call.respondText(file.readText(), ContentType.Text.Html)


        }





        get("/user/{id}") {

            val id = call.parameters["id"]
            id?.let { it1 -> RService.getUser(it1) }?.let { it2 -> call.respond(it2) }


        }


    }
}



