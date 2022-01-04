import React from "react";
import ToBase64 from "../Utils/UserFull";








function LogOff() {
  return (
    <div>
      <button
        onClick={() => {
          localStorage.removeItem("jwt");
          window.location.reload();
        }}
        className="btn btn-outline-danger"
      >
        <img
          style={{
            width: "25px",
            padding: "5px"
          }}
          src={"/images/logoff.png"}
          
        />
        Log Off
      </button>
    </div>
  );
}

export default LogOff;
