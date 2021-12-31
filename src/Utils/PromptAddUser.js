import React from "react";
import $ from "jquery";
import { adduserBTN } from "../Classes/Functions";
import { PromptAddUserCloseFromOutside } from "../Classes/Functions";

import "../Css/PromptAddUser.css";
import { DataContext } from "../Components/GenetalContext";

function PromptAddUser({ setVisibility, visibility }) {
  const { user } = React.useContext(DataContext);
  const [myUser, setMyUser] = React.useState(user);

  function serVisibilityfunc() {
    setVisibility(!visibility);
  }

  let newUser = {
    id: "",
    name: "",
    userName: "",
    messages: [],
    avatar: ""
  };

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
            <input
              onChange={(e) => {
                newUser.name = e.target.value;
              }}
              id="firstname"
              className="input"
              type="text"
              placeholder=" "
            />
            <div className="cut"></div>
            <label className="placeholder">Name</label>
          </div>
          <div className="input-container ic2">
            <input
              onChange={(e) => {
                newUser.userName = e.target.value;
              }}
              id="lastname"
              className="input"
              type="text"
              placeholder=" "
            />
            <div className="cut"></div>
            <label className="placeholder">Username</label>
          </div>
          <div className="input-container ic2">
            <input
              onChange={(e) => {
                newUser.id = e.target.value;
              }}
              id="email"
              className="input"
              type="text"
              placeholder=" "
            />
            <div className="cut"></div>
            <label className="placeholder">Friend ID</label>
          </div>

          <button
            onClick={async () => {
              let post = await fetch(
                `http://localhost:8080/add-friend/${myUser.id}`,
                {
                  method: "POST",
                  headers: { "Content-Type": "application/json" },
                  body: JSON.stringify(newUser)
                }
              );

              let data = await post.json();

              if (data.response === "Friend added") {
                window.location.reload();
              }

              console.log(data);

              setVisibility(!visibility);
            }}
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
