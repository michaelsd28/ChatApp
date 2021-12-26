import React,{useContext} from "react";
import { DataContext } from "../GenetalContext";

function FriendMessageBox({message}) {

  const [messageData,setMessageData] = React.useState(message);


  return (
    <>
      <li
  
      className="clearfix">
        <div className="message-data">
          <span className="message-data-time">{messageData.date}</span>
        </div>
        <div className="message my-message">{messageData.content}</div>
      </li>
    </>
  );
}

export default FriendMessageBox;
// https://www.bootdey.com/img/Content/avatar/avatar8.png