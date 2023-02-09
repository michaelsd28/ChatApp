package routes.FileHandler

import Services.MongoDB.FileHandler.GetFileDB
import Services.MongoDB.MongoDBService
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*


fun Application.SaveFile_route() {

    routing {

        get("/get-file/{fileID}") {

            val fileId = call.parameters["fileID"].toString()

            println("🤘  fileID:: $fileId")


            val getFileDB = GetFileDB(fileId)


            val file = getFileDB.execute()


            call.respondFile(file)


        }
    }

}