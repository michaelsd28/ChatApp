import React from "react";
import "../../Css/chat.css";

let friend = {
  id: "018",
  name: "ambar",
  userName: "ambarsd18",
  messages: [
    {
      id: "001",
      content: "Hello Kotlin",
      MyUserID: "028",
      date: "Dec 22, 2021, 1:42:24 PM",
      userToID: "018"
    }
  ],
  avatar: "https://cdn-icons-png.flaticon.com/512/2922/2922561.png"
};

function ProfileCard({ userFriend }) {

  const [user, setUser] = React.useState(userFriend);


  return (
    <li className="clearfix">
      <img src={ user.avatar} alt="avatar" />
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
