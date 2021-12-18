package com.example.models

import java.util.*

data class User(
    val id: UUID,
    val name: String,
    val password: String,
    val userName: String,
    val friends: List<UUID>,
    val messages: List<Message>,
    val groups: List<Group>,
    val avatar: String
)
