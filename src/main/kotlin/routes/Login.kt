package routes


import Services.Authentication.JWTServices
import Services.GlobalStore
import Services.MongoDB.UserAuthentication
import Services.MongoDB.MongoDBService
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.websocket.*
import model.UserLogin

fun Application.Login() {

    routing {

        post("/login") {

            val userLogin = call.receive<UserLogin>()



            var userAuthentication = UserAuthentication(userLogin);
            var mongoDBService = MongoDBService(userAuthentication)
            var user = mongoDBService.execute()

            var isLogin = mongoDBService.execute() as Boolean

            if (isLogin) {
              val token =  JWTServices.generateJWTToken(userLogin)

                call.respond(mapOf("status" to "success", "token" to token , "user" to userLogin.username))
            } else {
                call.respond(mapOf("status" to "fail"))
            }




        }
    }
}

