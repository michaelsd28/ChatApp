import React, { useContext } from "react";
import { DataContext } from "../Components/GenetalContext";

function RemoveFriendPrompt() {
  const { user } = useContext(DataContext);

  const [delUser, setDelUser] = React.useState(null);

  return (
    <>
      <div
        style={{
          position: "relative",
          left: "-20px"
        }}
      >
        <div className="input-group mb-3">
          <div className="input-group-prepend">
            <span className="input-group-text" id="basic-addon1">
              ID
            </span>
          </div>
          <input
            onChange={(e) => setDelUser(e.target.value)}
            type="text"
            className="form-control"
            placeholder="User ID"
            aria-label="Username"
            aria-describedby="basic-addon1"
          />
          <button
            onClick={async () => {
              let post = await fetch(
                "https://sleepy-woodland-84771.herokuapp.com/delete-user/" + delUser,
                {
                  method: "POST",
                  headers: { "Content-Type": "application/json" },
                  body: user.id
                }
              );

              let data = await post.json();
              if (data.response === "User deleted") {
                window.location.reload();
              } else {
                alert(data.response);
              }
            }}
            style={{
              margin: "0 10px 0 10px",
              zIndex: "1"
            }}
            className="btn btn-danger"
          >
            Remove
          </button>
        </div>
      </div>
    </>
  );
}

export default RemoveFriendPrompt;
