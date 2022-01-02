import React from "react";
import RemoveFriendPrompt from "./RemoveFriendPrompt";

function RemoveFriend() {

  const [show, setShow] = React.useState(true);

  return (
    <>
    <div>
      <button
        onClick={ () => {

          setShow(!show);
         
        }}
        style={{ margin: "0 10px 0 10px" }}
        className="btn btn-outline-warning"
      >
        
        <img
          style={{
            width: "25px",
            padding: "2px",
            margin: "0 10px 0 0px"
          }}
          src="/images/remove.png"
        />
        Remove Friend
      </button>
    </div>

    <div 
    
    style={{
      position: "absolute",
      top:"50px"
  }}
    
    >

{show ? (<RemoveFriendPrompt />):(<></>)}

    </div>
    </>
  );
}

export default RemoveFriend;
