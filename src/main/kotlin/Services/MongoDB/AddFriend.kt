package Services.MongoDB

import Services.Authentication.JWTServices
import Services.GlobalStore
import com.google.gson.Gson
import model.FriendUser
import model.Request.Req_add_friend
import model.User.User
import org.bson.Document

class AddFriend(private val newFriend: Req_add_friend) : Operation {

    override fun execute(): Boolean {

        try {


            // database connection
            val globalStore = GlobalStore.getGlobalStore()
            val collection = globalStore.GetCollection("Users")

            // get user from token
            val myUserName = JWTServices.getUsernameFromJWTToken(newFriend.token)
            val myUser = collection.find(Document("username", myUserName)).first()
            val myUserObject = Gson().fromJson(myUser.toJson(), User::class.java)
            val my_user_as_friend = myUserObject.ToFriend()

            // get friend from username
            val friendUser = collection.find(Document("username", newFriend.username)).first() ?: return false
            val friendUserObject = Gson().fromJson(friendUser.toJson(), User::class.java)
            val friend_user_as_friend = friendUserObject.ToFriend()


            // validate if friend is already in my friends list
            val hasFriend = myUserObject.hasFriend(newFriend.username)

            if (hasFriend) {
                return false
            }

            if (myUserObject.username == friendUserObject.username) {
                return false
            }

            // add friend to my friends list
            collection.updateOne(myUser, Document("\$push", Document("friends", Gson().toJson(friend_user_as_friend))))

            // add me to friend's friends list
            collection.updateOne(friendUser, Document("\$push", Document("friends", Gson().toJson(my_user_as_friend))))



            return true

        } catch (e: Exception) {
            return false
        }


    }

}




