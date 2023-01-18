package Services.MongoDB

import Services.GlobalStore
import model.FriendUser
import model.RegisterUser
import model.User
import org.bson.Document

class InsertUser(private val registerUser: RegisterUser) : Operation {




    override fun execute(): Boolean {

        print("Inserting user $registerUser into database")

        val globalStore = GlobalStore.getGlobalStore()
        val collection = globalStore.GetCollection("Users")

        // check if user already exists
        val isUser = collection.find(Document("username", registerUser.username)).first()



        return if (isUser != null) {
            false
        } else {
            val newUser = User().register(registerUser)
            collection.insertOne(newUser.toDocument())
            true
        }




    }


}