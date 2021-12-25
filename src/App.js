import React from "react";
import LoginPage from "./Components/Chat Components/LoginPage";
import ChatApp from "./Components/ChatApp";
import { DataProvider } from "./Components/GenetalContext";
import WebSocketClient from "./Components/Message/WebSocketClient";
import ProfileCard from "./Components/Profile/ProfileCard";

function App() {
  return (
    <>
      <div>
        <DataProvider>
          <div
            style={{
              backgroundColor: "black",

              height: "200vh",
              top: -20,
              position: "relative"
            }}
          >
            <h1>Hello World</h1>

            <ChatApp />
          </div>
        </DataProvider>
        {/* <LoginPage /> */}
      </div>
    </>
  );
}

export default App;
