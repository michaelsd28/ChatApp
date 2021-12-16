package com.example

import com.example.models.Response
import java.io.File

class Play {
}

fun main() {
    val response:Response = Response("Hello World")
    println(File("C:\\Users\\rd28\\Documents\\Coding\\IdeaProjects\\Kotlin\\chat-app\\src\\main\\kotlin\\com\\example\\index.html").readText() )
}