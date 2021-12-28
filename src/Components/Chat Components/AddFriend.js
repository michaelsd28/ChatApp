import React from "react";
import $ from "jquery";
import PromptAddUser from "../../Utils/PromptAddUser";
import { adduserBTN } from "../../Classes/Functions";

function AddFriend() {
  // $(".addUser-btn").on("click", function () {

  // });

  const [addUserPrompt, setAddUserPrompt] = React.useState(false);

  return (
    <>
      <div
        style={{
          position: "relative",
          top: "10px"
        }}
      >
        <button
          className="addUser-btn"
          onClick={() => {
            setAddUserPrompt(!addUserPrompt);
            adduserBTN();
          }}
          className="btn btn-link"
        >
          <img
            style={{
              height: 28
            }}
            src="/images/add-button.png"
          />
        </button>
        <label
          style={{
            fontFamily: "Mali"
          }}
        >
          add friend
        </label>
      </div>
      <div className="addUser-container" style={{ position: "absolute" }}>
        {/* <PromptAddUser setVisibility={setAddUserPrompt} visibility={addUserPrompt}/> */}
        {addUserPrompt && (
          <PromptAddUser
            setVisibility={setAddUserPrompt}
            visibility={addUserPrompt}
          />
        )}
      </div>
    </>
  );
}

export default AddFriend;
