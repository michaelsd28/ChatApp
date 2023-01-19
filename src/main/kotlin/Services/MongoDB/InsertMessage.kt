package Services.MongoDB

import Services.GlobalStore
import com.google.gson.Gson
import com.mongodb.client.model.UpdateOptions
import io.ktor.util.*
import model.FriendUser
import model.Request.Req_insert_message
import model.User.Message
import model.User.User
import org.bson.Document

class InsertMessage(val req_add_message: Req_insert_message) :Operation {



    override fun execute(): Boolean {

        val globalStore = GlobalStore.getGlobalStore()
        val collection = globalStore.GetCollection("Users")




        var sender = req_add_message.sender
        var receiver = req_add_message.receiver

        var token = req_add_message.token
        var messageObject: Message = Message().fromRequest(req_add_message)




        var isValidToken = Services.Authentication.JWTServices.validateJWTToken(token)

        if (!isValidToken) {
            return false
        }

        var user = collection.find(Document("username", sender)).first()


        var message_doc = Document.parse(Gson().toJson(messageObject))
        var updateUser = Document("\$push", Document("friends.\$[elem].messages", message_doc))
        var updateOptions = UpdateOptions().arrayFilters(listOf(Document("elem.username", receiver)))
        collection.updateOne(user, updateUser, updateOptions)



        // add message to receiver
        var friend = collection.find(Document("username", receiver)).first()
        var updateFriend = Document("\$push", Document("friends.\$[elem].messages", message_doc))
        var updateFriendOptions = UpdateOptions().arrayFilters(listOf(Document("elem.username", sender)))

        collection.updateOne(friend, updateFriend, updateFriendOptions)

















        return true





    }

}