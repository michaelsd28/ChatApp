import React from "react";

function MessageBox({ message }) {
  const [ messageData, setMessageData ] = React.useState(message);
  return (
    <>
      <li className="clearfix">
      <div
 
      className="message-data text-right">
        <span style={{ fontSize: 10 }} className="message-data-time">
          {messageData.date}
        </span>
      </div>
      <div 
      style={{backgroundColor:"#86c541"}}
      className="message other-message float-right my-message">{messageData.content}</div>
      </li>
    </>
  );
}

export default MessageBox;
