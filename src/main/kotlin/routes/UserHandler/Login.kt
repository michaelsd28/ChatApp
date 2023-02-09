package routes.UserHandler


import Services.Authentication.JWTServices
import Services.MongoDB.UserAuthentication
import Services.MongoDB.MongoDBService
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import model.UserLogin

fun Application.Login() {


    routing {

        post("/login") {

            val userLogin = call.receive<UserLogin>()



            val userAuthentication = UserAuthentication(userLogin);
            val mongoDBService = MongoDBService(userAuthentication)
            var user = mongoDBService.execute()

            val isLogin = mongoDBService.execute() as Boolean

            if (isLogin) {
              val token =  JWTServices.generateJWTToken(userLogin)

                call.respond(mapOf("status" to "success", "token" to token , "user" to userLogin.username))
            } else {
                call.respond(mapOf("status" to "fail"))
            }




        }
    }
}

