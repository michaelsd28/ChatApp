package Services.MongoDB

import Services.Authentication.JWTServices
import Services.GlobalStore
import com.google.gson.Gson
import model.FriendUser
import model.User.User
import org.bson.Document

class FindFriends(private val token: String) : Operation {


    override fun execute(): List<FriendUser> {

        val isValidToken = JWTServices.validateJWTToken(token)
        if (!isValidToken) {
            return listOf()
        }


        val userName = JWTServices.getUsernameFromJWTToken(token)

        val globalStore = GlobalStore.getGlobalStore()
        val collection = globalStore.GetCollection("Users")

        val user = collection.find(Document("username", userName)).first()

        var user_string = Gson().toJson(user)
        println("user_string: $user_string")
        var user_obj  = Gson().fromJson(user_string, User::class.java)





        return user_obj.friends


    }
}