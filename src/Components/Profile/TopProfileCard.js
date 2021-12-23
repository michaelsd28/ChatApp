import React, { useContext } from "react";
import { DataContext } from "../GenetalContext";

function TopProfileCard( {user} ) {
  return (
    <div class="col-lg-6">
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
      <div class="chat-about">
        <h6 class="m-b-0">{user.name}</h6>
        <small>Last seen: 2 hours ago</small>
      </div>
    </div>
  );
}

export default TopProfileCard;
