import React from "react";

function RemoveFriend() {
  let friend = {
    id: "018",
    name: "ambar",

    userName: "ambarsd18",
    messages: [
      {
        id: "001",
        content: "Hello Kotlin",
        MyUserID: "028",

        date: "Dec 22, 2021, 1:42:24 PM",
        userToID: "018"
      }
    ],
    avatar: "https://cdn-icons-png.flaticon.com/512/2922/2922561.png"
  };
  return (
    <div>
      <button
        onClick={async () => {
          let post = await fetch("http://localhost:8080/removefriend", {
            method: "POST",
            headers: {
              "Content-Type": "application/json"
            },
            body: JSON.stringify(friend)
          });
        }}
        style={{ margin: "0 10px 0 10px" }}
        className="btn btn-outline-warning"
      >
        <img
          style={{
            width: "2vw",
            padding: "2px",
            margin: "0 10px 0 0px"
          }}
          src="/images/remove.png"
        />
        Remove Friend
      </button>
    </div>
  );
}

export default RemoveFriend;
