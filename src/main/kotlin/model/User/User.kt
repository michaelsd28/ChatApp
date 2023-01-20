package model.User

import com.google.gson.Gson
import model.FriendUser
import model.Request.RegisterUser
import model.User.Message
import org.bson.Document

class User {
    // name, username, password, image, friends
    var name: String = ""
    var username: String = ""
    var password: String = ""
    var image: String = ""
    var friends: ArrayList<FriendUser> = ArrayList()


    fun register(registerUser: RegisterUser): User {
        name = registerUser.name
        username = registerUser.username
        password = registerUser.password
        image = registerUser.image
        return this

    }

    fun toDocument(): Document {
        var document = Document()
        document.append("name", name)
        document.append("username", username)
        document.append("password", password)
        document.append("image", image)
        document.append("friends", friends)

        return document

    }

    fun fromDocument(myUser: Document?): User {
        name = myUser?.getString("name") ?: ""
        username = myUser?.getString("username") ?: ""
        password = myUser?.getString("password") ?: ""
        image = myUser?.getString("image") ?: ""
        friends = myUser?.get("friends") as ArrayList<FriendUser>

        return this


    }


    // override fun toString(): String {
    override fun toString(): String {
        return "User(name='$name', username='$username', password='$password', image='$image', friends=$friends)"
    }

    fun addFriend(friendUserObject: FriendUser?) {

        friends.add(friendUserObject!!)

    }

    fun hasFriend(username: String): Boolean {
        return friends.any { friend -> friend.username == username }
    }

    fun ToFriend(): FriendUser {
        var friendUser = FriendUser()
        friendUser.name = name
        friendUser.username = username
        friendUser.image = image
        return friendUser


    }

    fun getMessages(userName: String): List<Message> {

        var messages = friends.find { friend -> friend.username == userName }?.messages ?: listOf()
        return messages

    }

    fun addMessage(messageObject: Message) {
        var friend = friends.find { friend -> friend.username == messageObject.receiver }

       var messages = friend?.messages?.plus(messageObject)

        friend?.messages = messages as ArrayList<Message>





    }

    companion object {
        fun fromDocument(user: Document?): User {

            // convert to User object
            /*{"_id": {"$oid": "63c49d9beaf2763214e2957a"}, "name": "postman_name2", "username": "postman_username2", "password": "1234", "image": "https://cdn.shopify.com/s/files/1/0238/7617/articles/e33c2fa94c03efa06678116f80d62d0d_708x.jpg?v=1590599656", "friends": [{"name": "postman_name", "username": "postman_username", "image": "https://staticg.sportskeeda.com/editor/2022/11/a402f-16694231050443-1920.jpg", "messages": []}]}*/
            // remove _id
            var userObject = User()
            userObject.name = user?.getString("name") ?: ""
            userObject.username = user?.getString("username") ?: ""
            userObject.password = user?.getString("password") ?: ""
            userObject.image = user?.getString("image") ?: ""
            userObject.friends = user?.get("friends") as ArrayList<FriendUser>

            var gson = Gson()
            var userString = gson.toJson(userObject)
            userObject = gson.fromJson(userString, User::class.java)




            return userObject






        }

        fun CleanJsonString(json: String): String {
            //{\"name\":\"postman_name\",\"username\":\"postman_username\",\"image\":\"https://staticg.sportskeeda.com/editor/2022/11/a402f-16694231050443-1920.jpg\",\"messages\":[]}
            var json = json.replace("\\", "")
            json = json.replace("\"{", "{")
            json = json.replace("}\"", "}")
            json = json.replace("\"[", "[")
            json = json.replace("]\"", "]")
            return json
        }


    }


}


