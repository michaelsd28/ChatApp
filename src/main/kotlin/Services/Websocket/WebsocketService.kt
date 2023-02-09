package Services.Websocket

import Services.GlobalStore
import Services.MongoDB.InsertMessage
import Services.MongoDB.MongoDBService
import com.google.gson.Gson
import io.ktor.server.plugins.*
import io.ktor.server.websocket.*
import io.ktor.websocket.*
import model.Request.WebSocketLogin
import model.User.Message

class WebsocketService {
    companion object {
        suspend fun HandleIncomming(text: Frame.Text, defaultWebSocketServerSession: DefaultWebSocketServerSession) {




            val message = text.readText()
            val messageObj = Message.fromString(message)

            val sessions = GlobalStore._sessions





            if (messageObj != null) {
                when (messageObj.type) {
                    "text" -> {

                        sessions.forEach { (key, connectedUser) ->
                            if ((key != messageObj.sender) && (key == messageObj.receiver)) {
                                println("send message to $key from ${messageObj.sender} ")
                                sendAndSaveMessage(messageObj, connectedUser)
                            }

                        }
                    }

                    "audio" -> {
                        defaultWebSocketServerSession.send("friend added")
                    }

                    "image" -> {
                        defaultWebSocketServerSession.send("friends received")
                    }

                    else -> {
                        println("unknown message type 🚫")
//                        session.send("unknown message type")
                    }
                }
            } else {


//                session.send("invalid message")
                println("invalid message 🚫")
            }


        }

        private suspend fun sendAndSaveMessage(messageObj: Message, connectedUser: DefaultWebSocketServerSession) {

            val message = Gson().toJson(messageObj)
            // insert message to db
            val insertMessage = InsertMessage(messageObj)
            val mongoDBService = MongoDBService(insertMessage)
//            mongoDBService.execute()

            connectedUser.send(message)

        }


        fun HandleNewUser(message: Frame.Text, session: DefaultWebSocketServerSession) {

            println("new user connected session.call.request.origin.remoteHost:: ${session.call.request.origin.remoteHost} session.call.request.origin.remotePort:: ${session.call.request.origin.remotePort} message:: $message")

            var message = message.readText()


            var webSocketLogin: WebSocketLogin = WebSocketLogin.fromString(message)
            var sessionStore = GlobalStore._sessions
            var userName: String = webSocketLogin.username

            var isUserAlreadyLoggedIn = sessionStore.containsKey(userName)

            if (!isUserAlreadyLoggedIn) {
                if (userName == "") {
                    println("username is blank or null")

                    return
                }
                println("new user added:: $userName")
//                session.send("user logged in")
                sessionStore[userName] = session

            } else {
                sessionStore[userName] = session
                println("user already logged in:: $userName")
                return
            }

        }
    }


}