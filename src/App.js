import React from "react";
import ChatApp from "./Components/ChatApp";
import WebSocketClient from "./Components/Message/WebSocketClient";


function App() {
  return (
    <div
      style={{
        backgroundColor: "black",
        color: "white",
        height: "200vh",
        top: -20,
        position: "relative"
      }}
    >
      <h1>Hello World</h1>
      <WebSocketClient />

      <ChatApp/>
    </div>
  );
}

export default App;
