package routes

import Services.MongoDB.GetMessages
import Services.MongoDB.InsertMessage
import Services.MongoDB.MongoDBService
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import model.Request.Req_insert_message

fun Application.Message() {

    // model.User.Message route
    routing{
        get ("/get-messages/{JWT_token}") {


       var token = call.parameters["JWT_token"]


            var GetMessages = GetMessages(token!!)
            var mongoDBService = MongoDBService(GetMessages)
           var messages = mongoDBService.execute()

            call.respond(messages)

        }

        post ("/add-messages") {


            var req_add_message = call.receive<Req_insert_message>()


            var InsertMessage = InsertMessage(req_add_message)
            var mongoDBService = MongoDBService(InsertMessage)
            var messages = mongoDBService.execute()

            call.respond(messages)

        }

    }



}