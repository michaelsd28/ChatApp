package routes


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

            println("UserLogin: $userLogin")    // UserLogin: UserLogin(username=123, password=123)

            var userAuthentication = UserAuthentication(userLogin);
            var mongoDBService = MongoDBService(userAuthentication)
           var user = mongoDBService.execute()

            var isLogin = mongoDBService.execute() as Boolean

            if (isLogin) {
              val token =  JWTServices.generateJWTToken(userLogin)

                call.respond(mapOf("status" to "success", "token" to token))
            } else {
                call.respond(mapOf("status" to "fail"))
            }




        }
    }
}
