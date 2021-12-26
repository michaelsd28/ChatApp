package com.example

import com.example.models.Message
import com.example.models.Response
import com.example.utils.MessageUtil
import com.google.gson.Gson
import java.io.File
import java.util.*

class Play {
}

fun main() {


    val file = File("src/main/resources/index.html")
    print(file.readText())
}