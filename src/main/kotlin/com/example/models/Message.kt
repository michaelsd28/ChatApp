package com.example.models

import java.util.*

data class Message(
    val id: String,
    val content: String,
    val MyUserID: String,
    val date: Date,
    val userToID:String
    )
