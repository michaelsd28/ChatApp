package Services.Websocket

import Services.GlobalStore
import Services.MongoDB.InsertMessage
import Services.MongoDB.MongoDBService
import com.google.gson.Gson
import io.ktor.server.plugins.*
import io.ktor.server.websocket.*
import io.ktor.websocket.*
import model.Request.Req_insert_message
import model.Request.WebSocketLogin
import model.User.Message

class WebsocketService {
    companion object {
        suspend fun HandleIncomming(text: Frame.Text, defaultWebSocketServerSession: DefaultWebSocketServerSession) {


            var session = defaultWebSocketServerSession
            var message = text.readText()
            var messageObj = Message.fromString(message)

            var sessions = GlobalStore._sessions





            if (messageObj != null) {
                when (messageObj.type) {
                    "text" -> {

                        sessions.forEach { (key, connectedUser) ->
                            if ((key != messageObj.sender) && (key == messageObj.receiver)) {
                                sendAndSaveMessage(messageObj, connectedUser)
                            }

                        }
                    }

                    "audio" -> {
                        session.send("friend added")
                    }

                    "image" -> {
                        session.send("friends received")
                    }

                    else -> {
                        session.send("unknown message type")
                    }
                }
            } else {
                session.send("invalid message")
            }


        }

        private suspend fun sendAndSaveMessage(messageObj: Message, connectedUser: DefaultWebSocketServerSession) {

            var message = Gson().toJson(messageObj)
            var InsertMessage = InsertMessage(messageObj)
            var mongoDBService = MongoDBService(InsertMessage)
            var messages = mongoDBService.execute()
            connectedUser.send(message)

        }


        suspend fun HandleNewUser(message: Frame.Text, session: DefaultWebSocketServerSession) {

            println("new user connected session.call.request.origin.remoteHost:: ${session.call.request.origin.remoteHost} session.call.request.origin.remotePort:: ${session.call.request.origin.remotePort} message:: $message")

            var message = message.readText()


            var webSocketLogin: WebSocketLogin = WebSocketLogin.fromString(message)
            var sessionStore = GlobalStore._sessions
            var userName:String = webSocketLogin.username

            var isUserAlreadyLoggedIn = sessionStore.containsKey(userName)

            if (!isUserAlreadyLoggedIn) {
                if (userName == ""){
                    println("username is blank")
                    session.send("username is blank")
                    return
                }
                println("new user added:: $userName")
                session.send("user logged in")
                sessionStore[userName] = session

            } else {
                println("user already logged in:: $userName")
                return
            }

        }
    }


}