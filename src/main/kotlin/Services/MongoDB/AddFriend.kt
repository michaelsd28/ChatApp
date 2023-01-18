package Services.MongoDB

import Services.GlobalStore
import com.google.gson.Gson
import model.FriendUser
import model.User
import org.bson.Document

class AddFriend (val newFriend: FriendUser): Operation {

    override fun execute(): Boolean {

        // TODO: Add friend to database and return true if successful

        println("AddFriend: $newFriend * method called in AddFriend.kt")


        val globalStore = GlobalStore.getGlobalStore()
        val collection = globalStore.GetCollection("Users")
        val myUsername: String = newFriend.username
        val myUser =  collection.find(Document("username", myUsername)).first()



        println("myUser: $myUser")

        // convert myUsert to User object
        val myUserObject = User().fromDocument(myUser)
        var hasFriend = myUserObject.hasFriend(newFriend)



        if (hasFriend) {
            return false
        }



        // insert myUserObject to database

        val gson = Gson()
        val newFriend:FriendUser = FriendUser().toFriendUser(myUser, newFriend.friend_username)
        val newFriend_string = gson.toJson(newFriend)
        collection.updateOne(myUser, Document("\$push", Document("friends", newFriend_string)))


        // do the same for the friend
            val friendUsername: String = newFriend.friend_username
            val myUser_document =  collection.find(Document("username", friendUsername)).first()

            val friendUserObject = FriendUser().toFriendUser(myUser_document, myUsername)
            val friendUser_string = gson.toJson(friendUserObject)

    collection.updateOne(myUser_document, Document("\$push", Document("friends", friendUser_string)))









        return true




    }

}


