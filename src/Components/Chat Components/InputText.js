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
  const { messages, friendID, connection, user } = useContext(DataContext);

  const [date, setDate] = useState(new Date());
  const [content, setContent] = useState("");
  const [id, setId] = useState(user.id);

  React.useEffect(() => {
    if (connection != null) {
      connection.onmessage = (evt) => {
        const data = JSON.parse(evt.data);
        console.log(data);
        setMessageData((messageData) => [...messageData, data]);
      };
    }

    setId(user.id);
  }, [id, connection, friendID, content, setContent, user]);

  return (
    <div className="chat-message clearfix">
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

              console.log(newMSG, "newMSG");

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
