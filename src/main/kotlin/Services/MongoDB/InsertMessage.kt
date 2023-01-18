package Services.MongoDB

import Services.GlobalStore
import com.google.gson.Gson
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
        var message = req_add_message.message
        var type = req_add_message.type
        var token = req_add_message.token
        var messageObject: Message = Message().fromRequest(req_add_message)

        var isValidToken = Services.Authentication.JWTServices.validateJWTToken(token)

        if (!isValidToken) {
            return false
        }

        var user = collection.find(Document("username", sender)).first()
        var userObject_list:List<FriendUser> = FriendUser().fromDocument_ListFriend(user)

        var friend = collection.find(Document("username", receiver)).first()
        val friendObject_list:List<FriendUser> = FriendUser().fromDocument_ListFriend(friend)

      // find sender and receiver
        var senderObject:FriendUser = userObject_list.find { it.username == receiver }!!
        var receiverObject:FriendUser = friendObject_list.find { it.username == sender }!!

        // add message to sender
        senderObject.messages = senderObject.messages.plus(messageObject)

        // add message to receiver
        receiverObject.messages = receiverObject.messages.plus(messageObject)

        // update sender
        var senderUpdate = Document("\$set", Document("friends", Gson().toJson(senderObject)))
        collection.updateOne(user, senderUpdate)

        // update receiver
        var receiverUpdate = Document("\$set", Document("friends", Gson().toJson(receiverObject)))
        collection.updateOne(friend, receiverUpdate)

        return true





    }

}