import React from "react";
import { setInterval } from "stompjs";
// import SockJS from "sockjs-client";
// import socketIOClient from "socket.io-client";

function WebSocketClient() {
  /* connect stomp client */
  const [messages, setMessages] = React.useState([]);
  const [connected, setConnected] = React.useState(false);
  const [connection, setConnection] = React.useState(null);





  function connectionWS() {

 
    if (connection == null) {
      setConnection(new WebSocket("ws://localhost:8080/ws"));
      setConnected(true);
    } 

    if ( connection !== null ) {
    connection.onopen = () => {
      console.log("WebSocket Client Connected");
    };

    connection.onmessage = evt => {
      console.log("Message Received: " + evt.data);
      setMessages(messages => [...messages, evt.data]);
    };

    connection.onclose = () => {
      console.log("WebSocket Client Disconnected");
      connection.close();
      setConnection(null);
      connectionWS();
    };


  }
    return connection;
  }




  connectionWS();

  React.useEffect(() => {


    console.log("open connection -");

    if (connected) {
      connection.addEventListener("message", function (event) {
        console.log("Message from server ", event.data);

        setMessages((messages) => [...messages, event.data]);
      });
    }

    // socket.close()
    // console.log("close connection -");
  }, [setConnection]);

  return (
    <div style={{ padding: 50 }}>
      <button
        className="btn-danger"
        onClick={() => {
          // connectionWS().send("Hello");
          connection.send("hi");

          setInterval(() => {
            connection.close();
          }, 1000);
        }}
      >
        send message
      </button>

      <input type="text" />
      <ul>
        <h4>messages</h4>

        {messages.map((message, index) => (
          <li key={index}>{message}</li>
        ))}
      </ul>
    </div>
  );
}

export default WebSocketClient;
