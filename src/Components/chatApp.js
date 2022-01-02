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
  const { user, id, setId, currentFriend, setCurrentFriend } =
    useContext(DataContext);

  const [myFriend, setMyFriend] = React.useState(currentFriend);

  const [messages, setMessages] = React.useState([]);

  React.useEffect(() => {
    // scroll to buttton

    $(".chat-history").animate({ scrollTop: 10000 }, "slow");
  }, [id, setId, myFriend, setMyFriend]);

  return (
    <div>
      <button
        className="btn btn-danger"
        onClick={() => {
          let msg = {
            date: "Jan 1, 2022, 8:32:40 PM",
            id: "001",
            userToID: "018",
            content: "hi",
            MyUserID: "028"
          };

          // let myFriendTest01 = currentFriend

          // myFriendTest01.messages.push(msg);

          // setMyFriend({...myFriend, messages: myFriendTest01.messages});

          console.log(myFriend);
          console.log(currentFriend);
        }}
      >
        add message
      </button>
      <button
        onClick={() => {
          console.log(myFriend.messages, "my friend");
          console.log(currentFriend.messages, "current friend");
        }}
        className="btn btn-warning"
      >
        get messages
      </button>
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
                <AddFriend />
                <ul className="list-unstyled chat-list mt-2 mb-0">
                  {user.friends &&
                    user.friends.map((friend, index) => {
                      return (
                        <div
                          onClick={() => {
                            setCurrentFriend(friend);
                            setMyFriend(friend);
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
                    {myFriend.messages &&
                      myFriend.messages.map((message) => {

                        if(message.userToID === user.id){
                          return <FriendMessageBox message={message} />;
                        } else{
                          return <MessageBox message={message} />;
                      
                        }

                   

                      })}

                    {/* {currentFriend.messages && currentFriend.messages.map((message) => {
                      return (
                        <div
                          onClick={() => {
                            
                            alert(message.content);
                   
                          }}
                        >
                          {message.MyUserID === user.id ? (
                            <MessageBox message={message} />
                          ) : (
                            <FriendMessageBox message={message} />
                          )}
                        </div>
                      );
                    })} */}
                  </ul>
                </div>

                <InputText
                  setMessageData={setMessages}
                  messageData={messages}
                  setMyFriend={setMyFriend}
                  myFriend={myFriend}
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
