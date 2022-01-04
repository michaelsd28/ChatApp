import React from "react";
import "../../Css/chat.css";
import $ from "jquery";
import { DataContext } from "../GenetalContext";

function ProfileCard({ userFriend, index }) {
  const [user, setUser] = React.useState(userFriend);
  const { currentFriend } = React.useContext(DataContext);

  return (
    <li
      onClick={() => {


        console.log(userFriend.id, currentFriend.id);
      }}
      className={
        currentFriend.id === userFriend.id
          ? "clearfix user-li active"
          : "clearfix user-li"
      }
    >
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
