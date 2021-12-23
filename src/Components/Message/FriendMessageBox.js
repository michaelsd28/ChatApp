import React,{useContext} from "react";
import { DataContext } from "../GenetalContext";

function FriendMessageBox({text,time}) {


  return (
    <>
      <li
  
      className="clearfix">
        <div className="message-data">
          <span className="message-data-time">{time}</span>
        </div>
        <div className="message my-message">{text}</div>
      </li>
    </>
  );
}

export default FriendMessageBox;
// https://www.bootdey.com/img/Content/avatar/avatar8.png