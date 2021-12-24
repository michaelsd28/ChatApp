import React, { createContext, useState } from "react";

export const DataContext = createContext();

export const DataProvider = ({ children }) => {
  const [state, setState] = useState("0");
  const [user, setUser] = useState({});
  const [userInputText, setUserInputText] = useState("");
  const [id, setId] = useState("");
  const [whoTo, setWhoTo] = useState("");
  const [connection, setConnection] = useState(null);

  if(connection!=null){
    connection.onopen = () => {
      connection.send("id-Client " + id);
    }
  }



  const [messages, setMessages] = useState([]);
  const [friendID, setFriendID] = useState("");

  React.useEffect(async () => {
    const response = await fetch("http://localhost:8080/user/" + id);
    

    const data = await response.json();

    setConnection(new WebSocket("ws://localhost:8080/send"));


    setUser(data);


  }, [id,setId]);




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
