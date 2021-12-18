package com.example.models

data class Group(
    val id: Int,
    val name: String,
    val description: String,
    val members: List<User>
    )