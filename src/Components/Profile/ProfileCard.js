import React from "react";
import "../../Css/chat.css";
import $ from "jquery";

function ProfileCard({ userFriend,index }) {
  const [user, setUser] = React.useState(userFriend);

  return (
    <li 


    
    onClick={() => {

      let currentBTN = $(`.user-li${index}`)

        $(`.user-li${index}`).toggleClass("active");



    }} className={`clearfix user-li${index}`}>
      <img src={user.avatar} alt="avatar" />
      <div className="about">
        <div className="name">{user.name}</div>
        <div className="status">
          <i className="fa fa-circle online"></i> online
        </div>
      </div>
    </li>
  );
}

export default ProfileCard;
