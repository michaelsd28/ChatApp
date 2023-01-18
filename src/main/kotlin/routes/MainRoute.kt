package routes

import io.ktor.server.application.*


fun Application.MainRoute() {

    Register()
    Login()
    AddFriend()
    GetFriends()


}