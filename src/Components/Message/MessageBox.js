import React from "react";

function MessageBox({ text,time }) {
  return (
    <>
      <li className="clearfix">
      <div className="message-data text-right">
        <span style={{ fontSize: 10 }} className="message-data-time">
          {time}
        </span>
      </div>
      <div className="message other-message float-right">{text}</div>
      </li>
    </>
  );
}

export default MessageBox;
