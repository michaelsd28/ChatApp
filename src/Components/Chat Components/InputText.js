import React, { useContext } from "react";
import { DataContext } from "../GenetalContext";

function InputText() {



  const {setUserInputText,messages, setMessages} = useContext(DataContext)

  return (
    <div class="chat-message clearfix">
      {messages.map(e => {

        return <h1>{e}</h1>
      })}
      <div class="input-group mb-0">
        <div class="input-group-prepend">
          <span class="input-group-text">
            <i class="fa fa-send"></i>
          </span>
        </div>
        <input
          type="text"
          class="form-control"
          placeholder="Enter text here..."
          onChange={(e)=>{
            setUserInputText(e.target.value)
          }}
        />
      </div>
    </div>
  );
}

export default InputText;
