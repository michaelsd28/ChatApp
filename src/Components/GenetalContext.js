import React, { createContext, useState } from "react";

export const DataContext = createContext();

export const DataProvider = ({ children }) => {
  const [user, setUser] = useState({});
  const [userInputText, setUserInputText] = useState("");
  const [id, setId] = useState("");
  const [whoTo, setWhoTo] = useState("");
  const [connection, setConnection] = useState(null);
  const [jwt, setJwt] = useState("");
  const [messages, setMessages] = useState([]);
  const [friendID, setFriendID] = useState("");

  if(connection!=null){
    connection.onopen = () => {
      connection.send("id-Client " + id);
    }
  }


  React.useEffect(async () => {
    const response = await fetch("http://localhost:8080/user/" + id);
    

    const data = await response.json();
    setConnection(new WebSocket("ws://localhost:8080/send"));
    setUser(data);


  }, [id,setId]);

  window.onbeforeunload = function () {
    connection.send("disconnect-client " + id);
  };




  return (
    <DataContext.Provider
      value={{
        user,
        setUser,
        userInputText,
        setUserInputText,
        id,
        setId,
        whoTo,
        setWhoTo,
        messages,
        setMessages,
        friendID,
        setFriendID,
        connection,
        setConnection,
      }}
    >
      {children}
    </DataContext.Provider>
  );
};
