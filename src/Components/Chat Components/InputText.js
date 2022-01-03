import React, { useContext, useState } from "react";
import { DataContext } from "../GenetalContext";
import { Message } from "../../Classes/Messsage";

var time = new Date();
time = time.toLocaleString("en-US", {
  dateStyle: "medium",
  timeStyle: "medium",
  hour12: true
});

function InputText({
  messageData,
  setMessageData,
  setMyFriend,
  myFriend,
  setUser
}) {
  // const [content , setContent] = useState("");
  const {
    messages,
    currentFriend,
    setCurrentFriend,
    connection,
    user,
    friends,
    setFriends
  } = useContext(DataContext);

  const [content, setContent] = useState("");
  const [id, setId] = useState(user.id);

  React.useEffect(() => {
    if (connection != null) {
      connection.onmessage = (evt) => {
        let message = JSON.parse(evt.data);

        if (currentFriend.id === message.MyUserID) {
          let myFriendTest01 = currentFriend;
          myFriendTest01.messages.push(message);
          setMyFriend({ ...myFriend, messages: myFriendTest01.messages });
          
        }
      };
    }

    setId(user.id);
  }, [
    id,
    connection,
    user,
    friends,
    setFriends,
    setCurrentFriend,
    currentFriend
  ]);

  return (
    <div className="chat-message clearfix">
      {messages.map((item) => (
        <h1>{item}</h1>
      ))}

      <div className="input-group mb-0">
        <div className="input-group-prepend">
          <span className="input-group-text">
            <i className="fa fa-send"></i>
          </span>
        </div>
        <input
          type="text"
          className="form-control"
          placeholder="Enter text here..."
          onKeyPress={(e) => {
            //get key code of enter
            let newMSG = new Message(
              "001",
              content,
              id,
              time,
              currentFriend.id
            );
            newMSG.date = time;
            newMSG.content = e.target.value;
            newMSG.userToID = currentFriend.id;
            newMSG.MyUserID = id;

            if (e.key === "Enter") {
              let myFriendTest01 = currentFriend;
              myFriendTest01.messages.push(newMSG);
              setMyFriend({ ...myFriend, messages: myFriendTest01.messages });

              connection.send("request-send " + JSON.stringify(newMSG));
              e.target.value = "";
              setContent("");
            }
          }}
        />
      </div>
    </div>
  );
}

export default InputText;
