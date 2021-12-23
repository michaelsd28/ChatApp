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
  const { state, setState, user,id,setId } = useContext(DataContext);


  useEffect(() => {
    // scroll to buttton

    $(".chat-history").animate({ scrollTop: 10000 }, "slow");
  }, []);

  return (
    <div>
      <h1>Chat App </h1>

      <div className="container">
        <h1>Enter your id</h1>
        <input 
        onChange={(e)=>{
             
          setId(e.target.value)
        }}
        
        
        type="text" placeholder="Enter your id" />
        <div className="row clearfix ">
          <div className="col-lg-12">
            <div className="card chat-app  chat-container">
              <div id="plist" className="people-list">
                <SearchChat />

                <ul className="list-unstyled chat-list mt-2 mb-0">
                  {user.friends &&
                    user.friends.map((friend) => {
                      return (
                        <li className="clearfix">
                          <img src={friend.avatar} alt="avatar" />
                          <div className="about">
                            <div className="name">{friend.name}</div>
                            <div className="status">
                              <i className="fa fa-circle online"></i> online
                            </div>
                          </div>
                        </li>
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
                    {user.friends &&
                      user.friends.map((item) => {
                        const messages = item.messages;


                        return messages.map((e) => {
                          if (e.userToID === user.id) {
                            return (
                              <MessageBox text={e.content} time={e.date} />
                            );
                          } else {
                            return (
                              <FriendMessageBox
                                text={e.content}
                                time={e.date}
                              />
                            );
                          }
                        });
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
