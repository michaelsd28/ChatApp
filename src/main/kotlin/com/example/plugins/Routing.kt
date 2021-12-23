package com.example.plugins

import com.example.Database.RedisDB
import com.example.models.Message
import com.example.models.Response
import com.example.models.User
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

    install(Webjars) {
        path = "/webjars" //defaults to /webjars
        zone = ZoneId.systemDefault() //defaults to ZoneId.systemDefault()
    }

    routing {
        get("/") {


//            respond html
            var file = File("src/main/resources/index.html")


            call.respondText(file.readText(), ContentType.Text.Html)


        }

        post("/post") {

            call.respond(Gson().fromJson(call.receiveText(), Response::class.java))

        }



        get("/user/{id}") {
//          respondJson
         val user:User =   Gson().fromJson(
             redisDB.connect().get(call.parameters["id"]!!),
             User::class.java)
            call.respond(user)
        }

        post ("/messages"){
            val message:Message = call.receive<Message>()
            val user:User =   Gson().fromJson(
                redisDB.connect().get(message.MyUserID),
                User::class.java)
            val receiver:User =   Gson().fromJson(
                redisDB.connect().get(message.userToID),
                User::class.java)
            user.friends[0].messages = user.friends[0].messages.plus(message)
            receiver.friends[0].messages = receiver.friends[0].messages.plus(message)
//                        user.friends[0].messages = emptyList()
//            receiver.friends[0].messages = emptyList()

            redisDB.connect().set(message.MyUserID,Gson().toJson(user))
            redisDB.connect().set(message.userToID,Gson().toJson(receiver))


            call.respond(Response("OK"))

        }
    }
}

