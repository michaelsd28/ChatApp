import React from "react";
import LoginPage from "./Components/Chat Components/LoginPage";
import ChatApp from "./Components/ChatApp";
import { DataProvider } from "./Components/GenetalContext";
import WebSocketClient from "./Components/Message/WebSocketClient";
import ProfileCard from "./Components/Profile/ProfileCard";

let style = {
  backgroundColor: "black",
  height: "200vh",
  top: -20,
  position: "relative"
}

function App() {
  const [jwt, setJwt] = React.useState("");

  React.useEffect(() => {
    const token = localStorage.getItem("jwt");
    if (token) {
      setJwt(token);
    } 
  }, []);

  return (
    <>


      <div style={jwt? style: {}}>
        <DataProvider>
          {jwt ? <ChatApp /> : <LoginPage />}
         
        </DataProvider>
      
      </div>
    </>
  );
}

export default App;
