import React from "react";
import "../../Css/chat.css";

function ProfileCard({ img, name, status }) {
  return (
    <li className="clearfix">
      <img src={img} alt="avatar" />
      <div className="about">
        <div className="name">{name}</div>
        <div className="status">
  
          <i className="fa fa-circle offline"></i> {status}
        </div>
      </div>
    </li>
  );
}

export default ProfileCard;
