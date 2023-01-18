package Services.MongoDB

import Services.GlobalStore
import com.mongodb.client.MongoCollection
import com.mongodb.client.MongoDatabase
import org.bson.Document

class MongoDBService(private val operation: Operation):Operation {
    override fun execute(): Any {

        return  operation.execute()
    }


}