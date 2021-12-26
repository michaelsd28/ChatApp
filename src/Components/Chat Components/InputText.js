import React, { useContext, useState } from "react";
import { DataContext } from "../GenetalContext";
import { Message } from "../../Classes/Messsage";

var time = new Date();
time = time.toLocaleString("en-US", {
  dateStyle: "medium",
  timeStyle: "medium",
  hour12: true
});

function InputText({ messageData, setMessageData }) {
  // const [content , setContent] = useState("");
  const {
    messages,
    setMessages,
    id,
    friendID,
    connection
  } = useContext(DataContext);

  const [date, setDate] = useState(new Date());
  const [msg, setMsg] = useState(new Message("001", "", id, date, friendID));
  const [content, setContent] = useState("");

  React.useEffect(() => {
    if (connection != null) {
      connection.onmessage = (evt) => {
        console.log(evt.data);
        setMessages((messageData) => [...messageData, "mmg"]);
      };
    }
  }, [id, connection, friendID, date, setDate, content, setContent]);

  return (
    <div className="chat-message clearfix">
      <h2 style={{ border: "1px solid #86c541" }} onClick={() => {}}>
        loco
      </h2>
      {messages.map((item) => (
        <h1>{item}</h1>
      ))}

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
            let newMSG = new Message("001", content, id, time, friendID);
            newMSG.date = time;
            newMSG.content = e.target.value;
            newMSG.userToID = friendID;
            newMSG.MyUserID = id;

            if (e.key === "Enter") {
              setMessageData((myMessages) => [...messageData, newMSG]);
              connection.send("request-send " + JSON.stringify(newMSG));

              e.target.value = "";
              setContent("");
            }
          }}
        />
      </div>
    </div>
  );
}

export default InputText;
