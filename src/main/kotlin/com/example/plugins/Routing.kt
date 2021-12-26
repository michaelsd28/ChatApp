package com.example.plugins

import com.example.Database.RedisDB
import com.example.models.Response
import com.example.models.User
import com.example.utils.JWTService
import com.example.utils.RService
import com.google.gson.Gson
import io.ktor.application.*
import io.ktor.features.*
import io.ktor.http.*
import io.ktor.http.content.*
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
    val JWTService = JWTService()

    install(Webjars) {
        path = "/webjars" //defaults to /webjars
        zone = ZoneId.systemDefault() //defaults to ZoneId.systemDefault()
    }

    routing {

        static("/static") {
            resources("static")
            default("index.html")
        }

        get("/") {

//            respond html with a body
            val file =
                File("C:\\Users\\rd28\\Documents\\Coding\\IdeaProjects\\Kotlin\\chat-app\\src\\main\\resources\\index.html")
            call.respondText(file.readText(), ContentType.Text.Html)
        }


        get("/user/{jwt?}") {

            val id = call.parameters["jwt"]
            var userString = id?.let { it1 -> JWTService.decodeJWT(it1) }
            if (userString != null) {
                userString = userString.substring(1, userString.length - 1).replace("\\", "")
            }

            println("$id this is the id and this is the userString $userString")
            val user: User = Gson().fromJson(userString, User::class.java)
            val userDB = redisDB.connect().get(user.id)
            val userDBJson: User = Gson().fromJson(userDB, User::class.java)

            call.respond(userDBJson)
        }

        post("register") {
            val user = call.receive<User>()
            val jsonUserString = Gson().toJson(user)
//            redisDB.connect().set(user.id, jsonUserString)

            val jwt = JWTService.createJWT(jsonUserString)
            call.respond(Response(jwt))
        }

        get("signin/{username}/{password}") {

            try {
                val user = redisDB.connect().get(call.parameters["username"])
                val userJson = Gson().fromJson(user, User::class.java)
                if (userJson.password == call.parameters["password"]) {
                    val jwt = JWTService.createJWT(Gson().toJson(userJson))
                    call.respond(Response(jwt))
                } else {
                    call.respond(Response("invalid username or password"))
                }

            } catch (e: Exception) {
                call.respond(Response("invalid username or password"))
            }

        }

    }


}




