package Services.MongoDB

import Services.GlobalStore
import model.UserLogin


class UserAuthentication(private val user: UserLogin) : Operation {


    override fun execute(): Boolean {
        val globalStore = GlobalStore.getGlobalStore()
        val collection = globalStore.GetCollection("Users")


        var userLogin =user.toDocument()

        val isUser = collection.find(userLogin).first()

        return isUser != null






    }


}