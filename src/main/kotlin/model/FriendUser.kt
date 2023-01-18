package model

import org.bson.Document


class FriendUser {

    var name: String = ""
    var username: String = ""
    var friend_username:String = ""
    var image: String = ""



fun fromDocument(addfriendDocument: Document): FriendUser {
    var friendUser = FriendUser()
    friendUser.name = addfriendDocument.getString("name")
    friendUser.username = addfriendDocument.getString("username")
    friendUser.friend_username = addfriendDocument.getString("friend_username")
    friendUser.image = addfriendDocument.getString("image")




    return friendUser

}

    override fun toString(): String {
        return "FriendUser(name=$name, username=$username, friend_username=$friend_username, image=$image)"
    }




    fun toFriendUser(myUser: Document?, newFriend: String): FriendUser {

        name = newFriend
        username = myUser?.getString("username") ?: ""
        friend_username = newFriend
        image = myUser?.getString("image") ?: ""
        return this

    }


}