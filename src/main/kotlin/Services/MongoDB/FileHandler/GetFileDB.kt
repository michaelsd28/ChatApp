package Services.MongoDB.FileHandler

import Services.MongoDB.Operation
import com.mongodb.client.MongoClient
import com.mongodb.client.MongoClients
import com.mongodb.client.gridfs.model.GridFSFile
import com.mongodb.client.model.Filters
import org.bson.types.ObjectId
import java.io.File
import java.io.FileInputStream
import java.io.InputStream
import javax.management.Query


class GetFileDB(private val fileID: String) : Operation {


    override fun execute(): File {

        val mongoClient: MongoClient = MongoClients.create("mongodb://localhost:6082/")
        val database = mongoClient.getDatabase("ChatDB")
        val bucket = com.mongodb.client.gridfs.GridFSBuckets.create(database, "files")


        // gridFsFile is null try to find file by name
        val mongodbObjectID = ObjectId(fileID)
        val gridFsFile: GridFSFile? = bucket.find(Filters.eq("_id", mongodbObjectID)).first()


        var newFile = File("")

        if (gridFsFile != null) {
            val downloadStream = bucket.openDownloadStream(gridFsFile.id)
            newFile = File(gridFsFile.filename)
            newFile.outputStream().use { downloadStream.copyTo(it) }
        }

        return newFile


//        val newFile = fileName?.let { File(it) }
//
//
//        newFile?.outputStream()?.use { downloadStream.copyTo(it) }
//
//      println("File saved to: ${gridFsFile.filename}")


    }


}