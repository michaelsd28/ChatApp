import React from "react";
import "../Css/chat.css";
import FriendMessageBox from "./Message/FriendMessageBox";
import MessageBox from "./Message/MessageBox";
import ProfileCard from "./Profile/ProfileCard";

var avatar1 = process.env.PUBLIC_URL + "/images/avatar1.png";

function ChatApp() {
  return (
    <div>
      <h1>Chat App</h1>

      <div className="container">
        <div className="row clearfix">
          <div className="col-lg-12">
            <div className="card chat-app">
              <div id="plist" className="people-list">
                <div className="input-group">
                  <div className="input-group-prepend">
                    <span className="input-group-text">
                      <i className="fa fa-search"></i>
                    </span>
                  </div>
                  <input
                    type="text"
                    className="form-control"
                    placeholder="Search..."
                  />
                </div>
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
                    <div className="col-lg-6">
                      <a
                        href="javascript:void(0);"
                        data-toggle="modal"
                        data-target="#view_info"
                      >
                        <img
                          src="https://bootdey.com/img/Content/avatar/avatar2.png"
                          alt="avatar"
                        />
                      </a>
                      <div className="chat-about">
                        <h6 className="m-b-0">Aiden Chavez</h6>
                        <small>Last seen: 2 hours ago</small>
                      </div>
                    </div>
                    <div className="col-lg-6 hidden-sm text-right">
                      <a
                        href="javascript:void(0);"
                        className="btn btn-outline-secondary"
                      >
                        <i className="fa fa-camera"></i>
                      </a>
                      <a
                        href="javascript:void(0);"
                        className="btn btn-outline-primary"
                      >
                        <i className="fa fa-image"></i>
                      </a>
                      <a
                        href="javascript:void(0);"
                        className="btn btn-outline-info"
                      >
                        <i className="fa fa-cogs"></i>
                      </a>
                      <a
                        href="javascript:void(0);"
                        className="btn btn-outline-warning"
                      >
                        <i className="fa fa-question"></i>
                      </a>
                    </div>
                  </div>
                </div>
                <div className="chat-history">
                  <ul className="m-b-0">
                    <MessageBox
                      text={
                        "Hi Aiden, how are you? How is the project coming along?"
                      }
                    />
                    <MessageBox text={"is everything ok ?"} />

                    <FriendMessageBox text="Are we meeting today?" />

                    <FriendMessageBox
                      text="Project has been already finished and I have results to
                        show you."
                    />
                  </ul>
                </div>
                <div className="chat-message clearfix">
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
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default ChatApp;
