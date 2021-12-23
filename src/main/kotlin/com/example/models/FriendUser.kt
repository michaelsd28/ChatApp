package com.example.models

data class FriendUser(
    val id: String,
    val name: String,
    val userName: String,
    var messages: List<Message>,
    val avatar: String,


    )
