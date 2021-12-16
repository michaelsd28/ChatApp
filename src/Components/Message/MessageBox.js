import React from "react";

function MessageBox({ text }) {
  return (
    <>
      <li className="clearfix">
      <div className="message-data text-right">
        <span style={{ fontSize: 10 }} className="message-data-time">
          10:10 AM, Today
        </span>
      </div>
      <div className="message other-message float-right">{text}</div>
      </li>
    </>
  );
}

export default MessageBox;
