import React, { createContext, useState } from "react";

export const DataContext = createContext();

export const DataProvider = ({ children }) => {
  const [user, setUser] = useState({});
  const [userInputText, setUserInputText] = useState("");
 const [currentFriend, setCurrentFriend] = useState({});
  const [connection, setConnection] = useState(null);
  const [messages, setMessages] = useState([]);

  const [friendID, setFriendID] = useState("");

  if (connection != null) {
    connection.onopen = () => {
      connection.send("id-Client " + user.id);
    };
  }

  React.useEffect(async () => {
    const token = localStorage.getItem("jwt");
    const response = await fetch("http://localhost:8080/user/" + token);
    const data = await response.json();

    setConnection(new WebSocket("ws://localhost:8080/send"));
    setUser(data);


  }, []);

  window.onbeforeunload = function () {
    connection.send("disconnect-client " + user.id);
  };

  return (
    <DataContext.Provider
      value={{
        user,
        setUser,
        userInputText,
        setUserInputText,
        messages,
        setMessages,
        friendID,
        setFriendID,
        connection,
        setConnection,
        currentFriend,
        setCurrentFriend
      }}
    >
      {children}
    </DataContext.Provider>
  );
};