package Services.MongoDB

import Services.Authentication.JWTServices
import Services.GlobalStore
import model.FriendUser
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

        val friends = user?.get("friends") as List<String>

        val friendsList: List<FriendUser> = friends.map { friend ->
            val friendDocument = Document.parse(friend)
            var newFriend = FriendUser()
            newFriend.name = friendDocument.getString("name")
            newFriend.username = friendDocument.getString("username")
            newFriend.image = friendDocument.getString("image")

            newFriend
        }



        println("<*>friendsList: $friendsList")

        return friendsList


    }
}