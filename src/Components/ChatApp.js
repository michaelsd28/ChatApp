import React, { useContext } from "react";
import "../Css/chat.css";
import FriendMessageBox from "./Message/FriendMessageBox";
import MessageBox from "./Message/MessageBox";
import ProfileCard from "./Profile/ProfileCard";
import $ from "jquery";
import TopProfileCard from "./Profile/TopProfileCard";
import TopButtons from "./Chat Components/TopButtons";
import InputText from "./Chat Components/InputText";
import SearchChat from "./Chat Components/SearchChat";
import { DataContext } from "./GenetalContext";
import { Message } from "../Classes/Messsage";
import AddFriend from "./Chat Components/AddFriend";
//laptop changes


function ChatApp() {
  const { user, id, setId, friendID, setFriendID } = useContext(DataContext);

  const [messages, setMessages] = React.useState([]);

  React.useEffect(() => {
    // scroll to buttton

    $(".chat-history").animate({ scrollTop: 10000 }, "slow");
  }, [id, setId]);

  return (
    <div>

      <div
        style={{
          position: "relative",
          top: "10vh"
        }}
        className="container"
      >
        <div className="row clearfix ">
          <div className="col-lg-12">
            <div className="card chat-app  chat-container">
              <div id="plist" className="people-list">
                <SearchChat />
                <AddFriend/>
                <ul className="list-unstyled chat-list mt-2 mb-0">
                  {user.friends &&
                    user.friends.map((friend) => {
                      return (
                        <div
                          onClick={() => {
                            setMessages(friend.messages);
                            setFriendID(friend.id);
                          }}
                        >
                          <ProfileCard userFriend={friend} />
                        </div>
                      );
                    })}
                </ul>
              </div>
              <div className="chat">
                <div className="chat-header clearfix">
                  <div className="row">
                    <TopProfileCard user={user} />
                    <TopButtons />
                  </div>
                </div>
                <div className="chat-history">
                  <ul className="m-b-0  chat-box">
                    {messages.map((message) => {
                      return (
                        <div
                          onClick={() => {
                            setFriendID(message.userToID);
                          }}
                        >
                          {message.MyUserID === user.id ? (
                            <MessageBox message={message} />
                          ) : (
                            <FriendMessageBox message={message} />
                          )}
                        </div>
                      );
                    })}
                  </ul>
                </div>

                <InputText
                  setMessageData={setMessages}
                  messageData={messages}
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default ChatApp;
