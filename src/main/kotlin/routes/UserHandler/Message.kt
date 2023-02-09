package routes.UserHandler

import Services.MongoDB.GetMessages
import Services.MongoDB.InsertMessage
import Services.MongoDB.MongoDBService
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import model.Request.ReqMessages
import model.Request.Req_insert_message

fun Application.Message() {

    // model.User.Message route
    routing {

        post("/get-messages") {


            var reqMessages: ReqMessages = call.receive()


            var GetMessages = GetMessages(reqMessages)
            var mongoDBService = MongoDBService(GetMessages)
            var messages = mongoDBService.execute()

            call.respond(messages)

        }



    }


}