package routes

import Services.Authentication.JWTServices
import Services.MongoDB.AddFriend
import Services.MongoDB.InsertUser
import Services.MongoDB.MongoDBService
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import model.FriendUser
import model.Request.Req_add_friend
import org.bson.Document


fun Application.AddFriend() {

    // AddFriend route
    routing {
        post("/add-friend") {

            // get AddFriend
            val newFriend = call.receive<Req_add_friend>()

           val isToken = JWTServices.validateJWTToken(newFriend.token)

            print("isToken: $newFriend.token")

            if (!isToken) {
                call.respond(mapOf("status" to "fail"))
                return@post
            }


            val insertUser = AddFriend(newFriend)
            val mongoDBService = MongoDBService(insertUser)
            val isRegister = mongoDBService.execute() as Boolean

            if (isRegister) {
                call.respond(mapOf("status" to "success"))
            } else {
                call.respond(mapOf("status" to "fail"))
            }

        }

    }

}


