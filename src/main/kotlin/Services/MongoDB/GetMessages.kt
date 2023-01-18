package Services.MongoDB

import Services.Authentication.JWTServices
import Services.GlobalStore
import com.google.gson.Gson
import model.User.Message
import model.User.User
import org.bson.Document

class GetMessages(var token: String) : Operation {

    override fun execute(): List<Message> {

        var gson = Gson()

        val globalStore = GlobalStore.getGlobalStore()
        val collection = globalStore.GetCollection("Users")

        var isValidToken = Services.Authentication.JWTServices.validateJWTToken(token)

        if (!isValidToken) {
            return listOf()
        }

        var userName = JWTServices.getUsernameFromJWTToken(token)
        var user = collection.find(Document("username", userName)).first()

        var userObject:User = User.fromDocument(user)



        var messages =  userObject.getMessages(userName)

        return messages


    }

}


