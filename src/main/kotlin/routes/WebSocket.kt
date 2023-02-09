package routes

import Services.Websocket.WebsocketService
import io.ktor.server.application.*
import io.ktor.server.routing.*
import io.ktor.server.websocket.*
import io.ktor.websocket.*
import java.time.Duration
import java.util.*
import java.util.concurrent.atomic.AtomicInteger
import kotlin.collections.LinkedHashSet


fun Application.WebSocket() {

    install(WebSockets) {
        pingPeriod = Duration.ofSeconds(1500000000000)
        timeout = Duration.ofSeconds(1500000000000)
        maxFrameSize = Long.MAX_VALUE
        masking = false
    }

    routing {
        webSocket("/chat-server") {


            for (frame in incoming) {

                var message = frame as Frame.Text
                var session = this




                WebsocketService.HandleNewUser (message, session)

                WebsocketService.HandleIncomming (message, session)




            }
        }






    }


}



