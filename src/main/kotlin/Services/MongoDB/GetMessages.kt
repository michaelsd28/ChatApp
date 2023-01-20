package Services.MongoDB

import Services.Authentication.JWTServices
import Services.GlobalStore
import com.google.gson.Gson
import model.Request.ReqMessages
import model.User.Message
import model.User.User
import org.bson.Document

class GetMessages(var reqMessages: ReqMessages) : Operation {

    override fun execute(): List<Message> {

        var gson = Gson()

        val globalStore = GlobalStore.getGlobalStore()
        val collection = globalStore.GetCollection("Users")
        var token = reqMessages.JWT_token
        var friend_username = reqMessages.friend_username

        var isValidToken = Services.Authentication.JWTServices.validateJWTToken(token)

        if (!isValidToken) {
            println("Invalid token")

            return listOf()
        }

        var userName = JWTServices.getUsernameFromJWTToken(token)
        var user = collection.find(Document("username", userName)).first()
        var userObject:User = User.fromDocument(user)




        // find friend
        userObject.friends.forEach {
            if (it.username == friend_username) {
                return it.messages
            }
        }




        return  listOf()
    }

}


