package Services

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.codecs.configuration.CodecRegistries.fromProviders
import org.bson.codecs.configuration.CodecRegistries.fromRegistries
import org.bson.codecs.pojo.PojoCodecProvider

// singleton
object GlobalStore  {

    val mongoClient: MongoClient = MongoClients.create("mongodb://localhost:6082/")








    val database = mongoClient.getDatabase("ChatDB")


    var _data = mutableMapOf<String, Any>()


    fun getGlobalStore(): GlobalStore {
        _data["database"] = database
        _data["mongoClient"] = mongoClient
        return this
    }


    fun GetCollection(collectionName: String): MongoCollection<Document> {
        // connect and insert data

        val globalStore = GlobalStore.getGlobalStore()

        val database = GlobalStore._data["database"] as MongoDatabase



        return database.getCollection(collectionName);


    }



}