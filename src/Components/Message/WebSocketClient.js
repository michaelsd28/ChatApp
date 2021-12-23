import React from "react";
import $ from "jquery";

function WebSocketClient() {
  /* connect stomp client */
  const [messages, setMessages] = React.useState([]);
  const [connected, setConnected] = React.useState(false);
  const [connection, setConnection] = React.useState(null);
  const [sessionId, setSessionId] = React.useState(
    localStorage.getItem("sessionId")
  );

  



  function connectWS() {
    if (connection == null) {
      setConnection(new WebSocket("ws://localhost:8080/send"));
      setConnected(true);
    }

    if (connection !== null) {
      connection.onopen = () => {
        console.log("WebSocket Client Connected");
        setConnected(true);
        alert("connected");
      };

      connection.onmessage = (evt) => {
        setMessages((messages) => [...messages, evt.data]);
      };

      connection.onclose = () => {
        console.log("WebSocket Client Disconnected");
        setConnected(false);
        alert("disconnected");
      };

      connection.onerror = (error) => {
        console.log("WebSocket Client Error: " + error);
        alert("error occured web socket");
      };
    }
  }

  function disconnectWS() {
    if (connected) {
      connection.send("disconnect " + sessionId);
      connection.close();
      // setConnection(null);
      setConnected(false);
      alert("disconnected");
    } else {
      alert("not connected");
    }
  }

  window.addEventListener("onbeforeunload", function (event) {
    disconnectWS();
  });

  window.onunload = function (event) {
    disconnectWS();
  };

  React.useEffect(() => {


    
  }, []);

  if (connection !== null) {
    connection.onmessage = (evt) => {
      if (evt.data.includes("Welcome to the server ")) {
        let id = evt.data.replace("Welcome to the server ", "");
        localStorage.setItem("sessionId", id);
        setSessionId(id);
      }
      console.log("Message Received: " + evt.data);
      setMessages((messages) => [...messages, evt.data]);
    };
  }

  return (
    <div style={{ padding: 50 }}>
      <div>
        <button
          className="btn btn-success connect-btn"
          onClick={() => {
            connectWS();
          }}
        >
          connect
        </button>

        <button
          className="btn btn-danger disconnect-btn"
          onClick={() => {
            if (connected) {
              connection.send("disconnect " + sessionId);
              connection.close();
              setConnection(null);
              setConnected(false);
              alert("disconnect");
            } else {
              alert("not connected");
            }
          }}
        >
          disconnect
        </button>
      </div>
      <button
        className="btn btn-light"
        onClick={(e) => {
          // if (isOpen(connection)) {
          // }
          connection.send(sessionId + " Hello from the client");
          // if(!isOpen(connection)) return;
        }}
      >
        send message
      </button>
      <button
        onClick={() => {
          setMessages([]);
        }}
        className="btn btn-warning"
      >
        clear messages
      </button>

      {/* <input type="text" /> */}
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
