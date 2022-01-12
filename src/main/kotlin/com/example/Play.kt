package com.example

import io.ktor.application.*
import java.io.BufferedReader
import java.io.File
import java.io.InputStreamReader


class Play {
}

fun main() {


//resources url
    val url = Application::class.java.getResource("/index.html")!!.file

    val fileIndex = File(url)

//    exec cmd command
//    val command = "cmd /c wsl redis-server"
//    val process = Runtime.getRuntime().exec(command)
//    val reader = BufferedReader(InputStreamReader(process.inputStream))
//
//    val line = reader.readLine()
//    println(line)
//    reader.close()
//    process.destroy()
//    exitProcess(0)

    //    exec cmd command

    val rt = Runtime.getRuntime()
    val commands = arrayOf("system.exe", "-get t")
    val proc = rt.exec(commands)

    val stdInput = BufferedReader(InputStreamReader(proc.inputStream))

    val stdError = BufferedReader(InputStreamReader(proc.errorStream))

// Read the output from the command

// Read the output from the command
    println("Here is the standard output of the command:\n")
    var s: String? = null
    while (stdInput.readLine().also { s = it } != null) {
        println(s)
    }

// Read any errors from the attempted command

// Read any errors from the attempted command
    println("Here is the standard error of the command (if any):\n")
    while (stdError.readLine().also { s = it } != null) {
        println(s)
    }


}

