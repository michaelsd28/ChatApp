import React, { useEffect, useContext } from "react";
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

var avatar1 = process.env.PUBLIC_URL + "/images/avatar1.png";

function ChatApp() {
  const { state, setState } = useContext(DataContext);
  /*
  data class User(
     id: UUID,
     name: String,
     password: String,
     userName: String,
     friends: List<UUID>,
     messages: List<Message>
)*/

  const message = {
    id: "001",
    content: "my message",
    user: "Michaelsd28",
    date: Date
  };
  const User = {
    id: "UUID",
    name: "Michaelsd28",
    password: "String",
    userName: "Michaelsd28",
    friends: ["ambar"],
    messages: [message]
  };

  const User2 = {
    id: "UUID",
    name: "Ambar",
    password: "String",
    userName: "Ambar",
    friends: ["ambar"],
    messages: [message]
  };

  const message1 = {
    id: "001",
    content: "my message",
    user: User,
    date: Date
  };

  const message2 = {
    id: "001",
    content: "my message",
    user: User2,
    date: Date
  };
  const message3 = {
    id: "001",
    content: "my message",
    user: User,
    date: Date
  };

  const listMessages = [message1, message2, message3];

  useEffect(() => {
    // scroll to buttton

    $(".chat-history").animate({ scrollTop: 10000 }, "slow");
  }, []);

  return (
    <div>
      <h1>Chat App </h1>

      <div className="container">
        <div className="row clearfix">
          <div className="col-lg-12">
            <div className="card chat-app">
              <div id="plist" className="people-list">
                <SearchChat />

                <ul className="list-unstyled chat-list mt-2 mb-0">
                  <ProfileCard
                    img={
                      "https://www.bootdey.com/img/Content/avatar/avatar8.png"
                    }
                    name="Ambar Santana"
                    status="online"
                  />

                  <ProfileCard
                    img={avatar1}
                    name="Michael Santana"
                    status="online"
                  />

                  <ProfileCard
                    img={
                      "https://ae01.alicdn.com/kf/HTB1_P7BaWL7gK0jSZFBq6xZZpXaL.jpg"
                    }
                    name="Mauricio Rodriguez"
                    status="online"
                  />
                </ul>
              </div>
              <div className="chat">
                <div className="chat-header clearfix">
                  <div className="row">
                    <TopProfileCard />
                    <TopButtons />
                  </div>
                </div>
                <div className="chat-history">
                  <ul className="m-b-0  chat-box">
                    {listMessages.map((item) => {
                    
                      if (item.user.userName === "Michaelsd28") {

                        return (
                          <MessageBox 
                          text={item.content} 
                          time={"10:12 PM"} />
                        );

                      } else {

                        return (
                          <FriendMessageBox
                            text={item.content}
                            time={"10:12 PM"}
                          />
                        );
                        


                      }
                    })}
                  </ul>
                </div>

                <InputText />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default ChatApp;
