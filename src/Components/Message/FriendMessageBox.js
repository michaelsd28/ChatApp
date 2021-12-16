import React from "react";

function FriendMessageBox({text}) {
  return (
    <>
      <li className="clearfix">
        <div className="message-data">
          <span className="message-data-time">10:12 AM, Today</span>
        </div>
        <div className="message my-message">{text}</div>
      </li>
    </>
  );
}

export default FriendMessageBox;
