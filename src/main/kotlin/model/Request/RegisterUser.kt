package model.Request

import model.FriendUser
import org.bson.Document

class RegisterUser {


    var name: String = ""
    var username: String = ""
    var password: String = ""
    var image:String = ""
    var friends:ArrayList<FriendUser> = ArrayList()

    fun toDocument(): Document {
        var document = Document()
        document.append("name", name)
        document.append("username", username)
        document.append("password", password)
        document.append("image", image)
        document.append("friends", friends)

        return document
    }

    override fun toString(): String {
        return "RegisterUser(name='$name', username='$username', password='$password', image='$image')"
    }
}