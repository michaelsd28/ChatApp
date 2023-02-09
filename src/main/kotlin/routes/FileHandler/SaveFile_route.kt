package routes.FileHandler

import Services.MongoDB.FileHandler.SaveFileDB
import Services.MongoDB.MongoDBService
import io.ktor.http.*
import io.ktor.http.content.*
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import java.io.File


fun Application.SaveFile() {

    routing {

        post("/save-file") {


            val multipartData = call.receiveMultipart()
            var fileDescription = ""
            var fileName = ""

            multipartData.forEachPart { part ->
                when (part) {
                    is PartData.FormItem -> {
                         fileDescription = part.value

                    }

                    is PartData.FileItem -> {
                         fileName = part.originalFileName as String

                        val fileBytes = part.streamProvider().readBytes()
                        // save file to uploads folder located in resources folder

                        val MongoDBService = MongoDBService(SaveFileDB(fileBytes, fileName))
                       val fileID = MongoDBService.execute().toString()

                            call.respondText(fileID)



                    }

                    else -> {}
                }
                part.dispose()
            }

//            call.respondText("$fileDescription is uploaded to 'uploads/$fileName'")

        }

    }

}