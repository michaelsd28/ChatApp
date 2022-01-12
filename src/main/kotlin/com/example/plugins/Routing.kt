package com.example.plugins

import com.example.Database.RedisDB
import com.example.Play
import com.example.models.FriendUser
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
import java.io.BufferedReader
import java.io.File
import java.io.InputStreamReader
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


        static {




            static("/static") {
                resources("static")
            }


            static("/images") {
                resources("images")
            }




        }

        get("/") {

            //respond html file

            try {
                Routing::class.java.getResourceAsStream("/index.html").use { `in` ->
                    BufferedReader(InputStreamReader(`in`)).use { reader ->
                        call.respondText(reader.readText(), ContentType.Text.Html)
                    }
                }
            } catch (e: Exception) {
               println("${e.message} could not load html file")

                call.respond(Response("error finding html file"))

            }

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
                friendUserDBJson.friends = friendUserDBJson.friends.plus(
                    FriendUser(
                        userDBJson.id,
                        userDBJson.name,
                        userDBJson.userName,
                        userDBJson.messages,
                        userDBJson.avatar
                    )
                )


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
                userJson.friends = emptyList()
                if (userJson.password == call.parameters["password"]) {
                    val jwt = JWTService.createJWT(Gson().toJson(userJson))
                    println("${jwt} this is the jwt and this is the user $userJson")
                    call.respond(Response(jwt))
                } else {
                    call.respond(Response("invalid username or password"))
                }

            } catch (e: Exception) {
                call.respond(Response("invalid username or password"))
            }

        }

        post("delete-user/{delUserID}") {

            val myUserID = call.receiveText()
            try {
                val delUserDB = redisDB.connect().get(call.parameters["delUserID"])
                val delUserDBJson: User = Gson().fromJson(delUserDB, User::class.java)
                delUserDBJson.friends = delUserDBJson.friends.filter { it.id != myUserID }

                val myUser = redisDB.connect().get(myUserID)
                val myUserJson: User = Gson().fromJson(myUser, User::class.java)
                myUserJson.friends = myUserJson.friends.filter { it.id != call.parameters["delUserID"] }

                redisDB.connect().set(call.parameters["delUserID"], Gson().toJson(delUserDBJson))
                redisDB.connect().set(myUserID, Gson().toJson(myUserJson))


            } catch (e: Exception) {
                println("error")
                call.respond(Response("Error deleting user"))
            }

            println("User deleted")
            call.respond(Response("User deleted"))


        }


        get("get-messages/{token}/{userID}/{friendID}") {


            try {

                val userID: String? = call.parameters["userID"]
                val friendID: String? = call.parameters["friendID"]
                val tokenID = userID?.let { it1 -> JWTService.validateToken(it1) }

                val userDB: User = Gson().fromJson(redisDB.connect().get(userID), User::class.java)
                val friendDB: FriendUser? = userDB.friends.find { it.id == friendID }



                call.respond(Gson().toJson(friendDB))

            } catch (e: Exception) {
                println("error")
                call.respond(Response("Error getting messages"))
            }


        }

    }


}




