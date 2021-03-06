import React, { createContext, useState } from "react";

export const DataContext = createContext();

export const DataProvider = ({ children }) => {
  const [user, setUser] = useState({});
  const [userInputText, setUserInputText] = useState("");
  const [currentFriend, setCurrentFriend] = useState({});
  const [connection, setConnection] = useState(null);
  const [messages, setMessages] = useState([]);
  const [friends, setFriends] = useState([]);

  if (connection != null) {
    connection.onopen = () => {
      connection.send("id-Client " + user.id);
    };
  }

  React.useEffect(async () => {
    const token = localStorage.getItem("jwt");
    const response = await fetch("https://sleepy-woodland-84771.herokuapp.com/user/" + token);
    const data = await response.json();

    setConnection(new WebSocket("ws://sleepy-woodland-84771.herokuapp.com/send"));
    setUser(data);

    setFriends(data.friends);



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
        connection,
        setConnection,
        currentFriend,
        setCurrentFriend,
        friends, 
        setFriends
      }}
    >
      {children}
    </DataContext.Provider>
  );
};
