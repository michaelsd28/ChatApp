import React, { useContext } from "react";
import { DataContext } from "../GenetalContext";

function TopProfileCard( {user} ) {
  return (
    <div className="col-lg-6">
      <a
        href="javascript:void(0);"
        data-toggle="modal"
        data-target="#view_info"
      >
        <img
          src={user.avatar}
          alt="avatar"
        />
      </a>
      <div className="chat-about">
        <h6 className="m-b-0">{user.name}</h6>
        <small>Last seen: 2 hours ago</small>
      </div>
    </div>
  );
}

export default TopProfileCard;
