import React from "react";
import ChatApp from "./Components/ChatApp";
import WebSocketClient from "./Components/Message/WebSocketClient";
import ProfileCard from "./Components/Profile/ProfileCard";


function App() {
  return (
    <div
      style={{
        backgroundColor: "black",
     
        height: "200vh",
        top: -20,
        position: "relative"
      }}
    >
      <h1>Hello World</h1>
      {/* <WebSocketClient /> */}



      <ChatApp/>
    </div>
  );
}

export default App;
