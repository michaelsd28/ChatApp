import React from "react";
import FriendMessageBox from "./FriendMessageBox";
import MessageBox from "./MessageBox";

function ChatHistory({ messageData, userData }) {
  const [message, setMessage] = React.useState(messageData);
  const [user, setUser] = React.useState(userData);

  //   this.id = id;
  //   this.content = content;
  //   this.MyUserID = MyUserID;
  //   this.date = date;
  //   this.userToID = userToID;
  return (
    <>
      <div className="chat-history">
        <ul className="m-b-0  chat-box">
          {message.MyUserID === user.id ? (
            <MessageBox message={message} />
          ) : (
            <FriendMessageBox message={message} />
          )}
        </ul>
      </div>
    </>
  );
}

export default ChatHistory;
