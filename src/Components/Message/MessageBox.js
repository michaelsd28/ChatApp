import React from "react";

function MessageBox({ text,time }) {
  return (
    <>
      <li className="clearfix">
      <div
 
      className="message-data text-right">
        <span style={{ fontSize: 10 }} className="message-data-time">
          {time}
        </span>
      </div>
      <div 
      style={{backgroundColor:"#86c541"}}
      className="message other-message float-right my-message">{text}</div>
      </li>
    </>
  );
}

export default MessageBox;
