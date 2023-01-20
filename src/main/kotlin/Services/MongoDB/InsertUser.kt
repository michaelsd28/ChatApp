package Services.MongoDB

import Services.GlobalStore
import model.Request.RegisterUser
import model.User.User
import org.bson.Document

class InsertUser(private val registerUser: RegisterUser) : Operation {




    override fun execute(): Boolean {



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