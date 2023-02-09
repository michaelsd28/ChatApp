package Services.MongoDB.FileHandler

import Services.GlobalStore
import Services.MongoDB.Operation
import com.mongodb.client.MongoClient
import com.mongodb.client.MongoClients
import com.mongodb.client.MongoDatabase
import com.mongodb.client.gridfs.GridFSBuckets
import java.io.File

class SaveFileDB(private val newFile: ByteArray, private val fileName: String) : Operation {


    override fun execute(): String {

        // database connection
        val mongoClient: MongoClient = MongoClients.create("mongodb://localhost:6082/")
        val database = mongoClient.getDatabase("ChatDB")

        // save file to database
        val bucket = GridFSBuckets.create(database, "files")

        // save new file
        val id = bucket.uploadFromStream(fileName, newFile.inputStream())


        // return file id
        return id.toString()

    }


}