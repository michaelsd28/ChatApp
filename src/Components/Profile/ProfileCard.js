import React from "react";
import "../../Css/chat.css";

function ProfileCard({ userFriend}) {
  return (
    <li className="clearfix">
      <img src={"userFriend.avatar"} alt="avatar" />
      <div className="about">
        <div className="name">{"userFriend.name"}</div>
        <div className="status">
  
          <i className="fa fa-circle offline"></i> online
        </div>
      </div>
    </li>
  );
}

export default ProfileCard;
