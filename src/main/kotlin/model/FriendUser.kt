package model

import com.google.gson.Gson
import model.User.Message
import org.bson.Document


class FriendUser {
  /*  {
        "name ": "postman_name ",
        "username ": "postman_username ",
        "image ": "https://staticg.sportskeeda.com/editor/2022/11/a402f-16694231050443-1920.jpg ",
        "messages ": []
    }*/

    var name: String = ""
    var username: String = ""
    var image: String = ""
    var  messages:List<Message> =  ArrayList();



fun fromDocument(addfriendDocument: Document): FriendUser {
    var friendUser = FriendUser()
    friendUser.name = addfriendDocument.getString("name")
    friendUser.username = addfriendDocument.getString("username")
    friendUser.image = addfriendDocument.getString("image")
    friendUser.messages = addfriendDocument.getList("messages", Message::class.java)



    return  friendUser








}

    override fun toString(): String {
        return "FriendUser(name=$name, username=$username, image=$image, messages=$messages)"
    }




    fun toFriendUser(myUser: Document?, newFriend: String): FriendUser {

        name = newFriend
        username = myUser?.getString("username") ?: ""
        image = myUser?.getString("image") ?: ""
        messages = ArrayList<Message>()
        return this

    }

    fun fromDocument_ListFriend(user: Document?): List<FriendUser> {

        var listFriend:List<FriendUser> = ArrayList()
        var listFriendString = user?.get("friends")
        var listFriendStringJson = Gson().fromJson(listFriendString.toString(), Array<FriendUser>::class.java)
        println("listFriendString: $listFriendString || listFriendString: $listFriendString")

        for (friend in listFriendStringJson) {
            listFriend += friend

        }

        return listFriend




    }

    fun CleanJsonString (json:String):String{
        // original "{\"name\":\"postman_name\",\"username\":\"postman_username\",\"image\":\"https://staticg.sportskeeda.com/editor/2022/11/a402f-16694231050443-1920.jpg\",\"messages\":[]}"
     // after { "name ": "postman_name ", "username ": "postman_username ", "image ": "https://staticg.sportskeeda.com/editor/2022/11/a402f-16694231050443-1920.jpg ", "messages ":[]}

    var newJson = json.replace("\\\"", "\"")
    newJson = newJson.replace("\"{", "{")
    newJson = newJson.replace("}\"", "}")
    newJson = newJson.replace("\\", "")
    return newJson


    }


}