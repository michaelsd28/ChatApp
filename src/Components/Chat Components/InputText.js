import React, { useContext, useState } from "react";
import { DataContext } from "../GenetalContext";
import { Message } from "../../Classes/Messsage";

function InputText() {
  // const [content , setContent] = useState("");
  const { setUserInputText, messages, setMessages, id, friendID, setFriendID,connection } =
    useContext(DataContext);

    const [chatMessages, setChatMessages] = React.useState([]);

  let msg = new Message("001", "", id, new Date(), friendID);




// console.log(id," this is id")


  // const ws = new WebSocket("ws://localhost:8080/send");

  React.useEffect(() => {




    if(connection!=null){
    connection.onmessage = (evt) => {
        console.log(evt.data);
        setMessages((myMessages) => [...myMessages, evt.data]);
    }
  }
    console.log("this is id", id);

 
}, [id,connection])

  // this.id = id;
  // this.content = content
  // this.MyUserID = MyUserID;
  // this.date = date;
  // this.userToID = userToID;

  return (
    <div className="chat-message clearfix">
      {messages.map((item) => (
      <h1>{item}</h1>)
      )}
      

      <div className="input-group mb-0">
        <div className="input-group-prepend">
          <span className="input-group-text">
            <i className="fa fa-send"></i>
          </span>
        </div>
        <input
          type="text"
          className="form-control"
          placeholder="Enter text here..."
          onKeyPress={(e) => {
            //get key code of enter
            setUserInputText(e.target.value);
            if (e.key === "Enter") {
              let message = e.target.value;

              msg.content = e.target.value;
              connection.send("request-send " + JSON.stringify(msg));
              console.log("request-send " + JSON.stringify(message));

              e.target.value = "";
            }
          }}
        />
      </div>
    </div>
  );
}

export default InputText;
