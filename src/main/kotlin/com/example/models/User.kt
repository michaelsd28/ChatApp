package com.example.models

import java.util.*

data class User(
    val id: String = UUID.randomUUID().toString(),
    val name: String = "",
    val password: String = "",
    val userName: String = "",
    var friends: List<FriendUser> = emptyList(),
    var messages: List<Message> = emptyList(),
    var groups: List<Group> = emptyList(),
    var avatar: String = "",
)
{
    fun addFriend(friend: FriendUser) {
        friends = friends.plus(friend)
    }

    fun addMessage (message: Message) {
        messages = messages.plus(message)
    }

    fun removeMessage (message: Message) {
        messages = messages.minus(message)
    }

    fun addGroup (group: Group) {
        groups = groups.plus(group)
    }

    fun removeGroup (group: Group) {
        groups = groups.minus(group)
    }
}
