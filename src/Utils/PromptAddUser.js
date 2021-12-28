import React from "react";
import $ from "jquery";
import { adduserBTN } from "../Classes/Functions";
import {PromptAddUserCloseFromOutside} from "../Classes/Functions";

import "../Css/PromptAddUser.css";

function PromptAddUser({ setVisibility, visibility }) {

function serVisibilityfunc(){
setVisibility(!visibility);
}

PromptAddUserCloseFromOutside(serVisibilityfunc);


  return (
    <div onClick={(e) => {}}>
      <div
        id="prompt-add-user"
        style={{
          position: "absolute"
        }}
      >
        <button
          onClick={() => {
            setVisibility(!visibility);
          }}
          style={{
            borderRadius: "50%",
            position: "absolute",
            top: "-10px",
            right: "-10px"
          }}
          className="btn btn-danger"
        >
          X
        </button>
        <div
          style={{
            border: "3px solid gray"
          }}
          className="form"
        >
          <div className="title">Add a user</div>
          <div className="subtitle">Add your new friend</div>
          <div className="input-container ic1">
            <input id="firstname" className="input" type="text" placeholder=" " />
            <div className="cut"></div>
            <label for="firstname" className="placeholder">
              Name
            </label>
          </div>
          <div className="input-container ic2">
            <input id="lastname" className="input" type="text" placeholder=" " />
            <div className="cut"></div>
            <label for="lastname" className="placeholder">
              Username
            </label>
          </div>
          <div className="input-container ic2">
            <input id="email" className="input" type="text" placeholder=" " />
            <div className="cut cut-short"></div>
            <label for="email" className="placeholder">
              Cell
            </label>
          </div>

          <button
            style={{ position: "relative" }}
            type="text"
            className="submit btn btn-danger"
          >
            <img
              style={{
                height: 28,
                position: "absolute",
                float: "left",
                left: "10px",
                filter: "invert(100%)",
                opacity: "0.9"
              }}
              src="/images/add2.png"
            />
            Add
          </button>
        </div>
      </div>
    </div>
  );
}

export default PromptAddUser;
