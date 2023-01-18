package model

import org.bson.Document
import org.bson.conversions.Bson

class User {
    // name, username, password, image, friends
    var name: String = ""
    var username: String = ""
    var password: String = ""
    var image: String = ""
    var friends: ArrayList<FriendUser> = ArrayList()
    var messages: ArrayList<Message> = ArrayList()


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
        return "User(name='$name', username='$username', password='$password', image='$image', friends=$friends, messages=$messages)"
    }

    fun hasFriend(newFriend: FriendUser): Boolean {
        var userName = newFriend.friend_username

        for (friend in friends) {
            if (friend.friend_username == userName) {
                return true
            }
        }

        return false
    }


}