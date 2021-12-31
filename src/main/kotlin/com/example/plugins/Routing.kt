package com.example.plugins

import com.example.Database.RedisDB
import com.example.models.FriendUser
import com.example.models.Message
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
import java.time.ZoneId


fun Application.configureRouting() {
    install(CORS) {
//        allow all
        anyHost()
        header(HttpHeaders.ContentType)
        header(HttpHeaders.Authorization)

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
//            val file =
//                File("C:\\Users\\rd28\\Documents\\Coding\\IdeaProjects\\Kotlin\\chat-app\\src\\main\\resources\\index.html")
//            call.respondText(file.readText(), ContentType.Text.Html)
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
            val userDB = redisDB.connect().get(user.id)

            if (userDB == null) {
                redisDB.connect().set(user.id, Gson().toJson(user))
                println("user created")
                call.respond(Response("User created"))
            } else {
                println("user already exists")
                call.respond(Response("User already exists"))
            }
        }

        post("/add-friend/{userID}") {

            try {
                val friendUser = call.receive<FriendUser>()
                val userDB = redisDB.connect().get(call.parameters["userID"])
                val userDBJson: User = Gson().fromJson(userDB, User::class.java)
                val friendUserDB = redisDB.connect().get(friendUser.id)
                val friendUserDBJson: User = Gson().fromJson(friendUserDB, User::class.java)
                friendUser.avatar = friendUserDBJson.avatar



                userDBJson.friends = userDBJson.friends.plus(friendUser)
                friendUserDBJson.friends = friendUserDBJson.friends.plus(FriendUser( userDBJson.id, userDBJson.name, userDBJson.userName, userDBJson.messages, userDBJson.avatar))


                redisDB.connect().set(friendUser.id, Gson().toJson(friendUserDBJson))
                redisDB.connect().set(call.parameters["userID"], Gson().toJson(userDBJson))

                call.respond(Response("Friend added"))
            } catch (e: Exception) {
                println("error")
                call.respond(Response("Error adding friend"))
            }

        }


    get("signin/{username}/{password}") {

        try {
            val user = redisDB.connect().get(call.parameters["username"])
            val userJson = Gson().fromJson(user, User::class.java)
            userJson.avatar = "https://www.gravatar.com/avatar/"
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




