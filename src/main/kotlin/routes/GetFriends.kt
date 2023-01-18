package routes

import Services.MongoDB.FindFriends
import Services.MongoDB.MongoDBService
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import model.FriendUser


fun Application.GetFriends() {

        routing {

            get("/get-friends/{JWT_token}") {

                val token = call.parameters["JWT_token"]
                println("token: $token")


                val getFriends = FindFriends(token!!)
                var mongoDBService = MongoDBService(getFriends)
                val friends =  mongoDBService.execute()


                call.respond(friends)




            }
        }
}

