package Services.MongoDB

import org.bson.Document


interface Operation {
    fun execute(): Any

}