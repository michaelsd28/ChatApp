import React from "react";


// import SockJS from "sockjs-client";
// import socketIOClient from "socket.io-client";

function WebSocketClient() {
  /* connect stomp client */
  const [messages, setMessages] = React.useState([]);
  const [connected, setConnected] = React.useState(false);
  const [connection, setConnection] = React.useState(
    new WebSocket("ws://localhost:8080/multiple")
  );

  // This can also be an async getter function. See notes below on Async Urls.




  React.useEffect(() => {
    // socket.close()
    // console.log("close connection -");
  }, []);

  return (
    <div style={{ padding: 50 }}>
      <button
        className="btn-danger"
        onClick={() => {
          
          const connection = new WebSocket("ws://localhost:8080/multiple");
          connection.onopen = () => {
            console.log("open connection");
          };
          connection.onmessage = event => {
            console.log("message", event.data);
            setMessages(messages => [...messages, event.data]);
          };
        
    

          // clear messages
          // setMessages([]);
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
