import React from "react";
import SockJS from "sockjs-client";
import socketIOClient from "socket.io-client";


const StompJs = require('@stomp/stompjs');







function WebSocketClient() {
  /* connect stomp client */


  React.useEffect(() => {
    console.log("open connection -");
    
   

    const socket = new WebSocket('ws://localhost:8080/multiple')
    socket.onopen = () => {
      console.log('Succesfully connected to chat server at ws://localhost:8080/chat')
      socket.send('Hello')
    
  }

  socket.onmessage = (event) => {
    console.log(event.data + " event " + event) 
  }

  socket.onerror = (error) => {
    console.log(error)
  }




  // socket.close()
    console.log("close connection -");
  }, []);

  return (
    <div style={{ padding: 50 }}>

  


      <input type="text" />
      <ul>
        <h4>messages</h4>
        <li>1</li>
        <li>2</li>
      </ul>
    </div>
  );
}

export default WebSocketClient;
