import React from "react";

function WebSocketClient() {
  /* connect stomp client */
  const [messages, setMessages] = React.useState([]);
  const [connected, setConnected] = React.useState(false);
  const [connection, setConnection] = React.useState(null);
  const [sessionId, setSessionId] = React.useState(null);

  function connectionWS() {
    if (connection == null) {
      setConnection(new WebSocket("ws://localhost:8080/ws"));
      setConnected(true);
    }

    if (connection !== null) {
      connection.onopen = () => {
        console.log("WebSocket Client Connected");
        setConnected(true);
      };

      connection.onmessage = (evt) => {
        if (evt.data.includes("Welcome to the server ")) {
          console.log("Message Received: " + evt.data);
          setMessages([...messages, evt.data]);
          let id = evt.data.replace("Welcome to the server ", "");
          setSessionId(id);
        } else {
          console.log("Message Received: " + evt.data);
          setMessages((messages) => [...messages, evt.data]);
        }

        console.log("your session id is: " + sessionId);
      };

      connection.onclose = () => {
        console.log("WebSocket Client Disconnected");
        connectionWS();
      };
    }
    return connection;
  }

  function isOpen(ws) { return ws.readyState === ws.OPEN }

  if (!connected) {
    connectionWS();
  }
  connectionWS();

  React.useEffect(() => {
    console.log("open connection -");
    // console.log("close connection -");
  }, []);




  return (
    <div style={{ padding: 50 }}>
      <button
        className="btn-danger"
        onClick={() => {
    
          if (isOpen(connection)) {
            connection.send(sessionId+ " Hello from the client");
          }  

          if(!isOpen(connection)) return;

       
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
