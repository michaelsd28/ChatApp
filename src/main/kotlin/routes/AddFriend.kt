package routes

import Services.MongoDB.AddFriend
import Services.MongoDB.InsertUser
import Services.MongoDB.MongoDBService
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import model.FriendUser
import org.bson.Document


fun Application.AddFriend() {

    // AddFriend route
    routing {
        post("/add-friend") {

            // get AddFriend
            val addFriend = call.receive<FriendUser>()

            println("AddFriend: $addFriend")

            call.respond(addFriend)




            val insertUser = AddFriend(addFriend)
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


