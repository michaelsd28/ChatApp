package routes

import io.ktor.server.application.*
import routes.FileHandler.SaveFile
import routes.FileHandler.SaveFile_route
import routes.UserHandler.*


fun Application.MainRoute() {

    Register()
    Login()
    AddFriend()
    GetFriends()
    Message()
    WebSocket()
    SaveFile()
    SaveFile_route()


}