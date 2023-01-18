package model

import org.bson.Document


class UserLogin {
    fun toDocument(): Document {

        return Document("username", username).append("password", password)


    }

    val username: String = ""
    val password: String = ""

}