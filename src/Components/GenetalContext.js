import React, { createContext, useState } from "react";

export const DataContext = createContext();

export const DataProvider = ({ children }) => {
  const [state, setState] = useState("0");
  const [user, setUser] = useState({});
  const [userInputText, setUserInputText] = useState("");
  const [id, setId] = useState("");
  const [whoTo, setWhoTo] = useState("");
  const [connection, setConnection] = useState(null);
  const [messages, setMessages] = useState([]);

  function setWSConnection(connectionws) {
    setConnection(connectionws);
  }

  React.useEffect(async () => {
    const response = await fetch("http://localhost:8080/user/" + id);
    // waits until the request completes...
    const data = await response.json();

    setUser(data);

  

  }, [setId, id, setUser]);

  const ws = new WebSocket("ws://localhost:8080/send");
  const ws2 = new WebSocket("ws://localhost:8080/send");

  ws.onopen = () => {
    console.log("WebSocket Client Connected");
    ws.send("id-Client " + id);
  };
  ws.onmessage = (evt) => {
    console.log(evt.data +"  " + id);

    if (evt.data.includes("message ")) {
      // let message = evt.data.replace("message ", "");
      // setMessages((messages) => [...messages, message]);
      // console.log(evt.data);
    }
  };



  return (
    <DataContext.Provider
      value={{
        state,
        setState,
        user,
        setUser,
        userInputText,
        setUserInputText,
        id,
        setId,
        whoTo,
        setWhoTo,
        messages, 
        setMessages
      }}
    >
      {children}
    </DataContext.Provider>
  );
};
