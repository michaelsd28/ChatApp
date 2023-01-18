package routes

import Services.MongoDB.InsertUser
import Services.MongoDB.MongoDBService
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import model.Request.RegisterUser

fun Application.Register() {

    routing{

        post("/register") {
            // get RegisterUser
            val registerUser = call.receive<RegisterUser>()

            println("RegisterUser: $registerUser")

            val insertUser = InsertUser(registerUser)
            val mongoDBService = MongoDBService(insertUser)
            val isRegister = mongoDBService.execute() as Boolean

            if (isRegister) {
                call.respond(mapOf("status" to "success"))
            } else {
                call.respond(mapOf("status" to "fail"))
            }






        }

    }
    // Register route



}