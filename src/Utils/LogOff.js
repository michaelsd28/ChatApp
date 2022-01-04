import React from "react";

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
          src={process.env.PUBLIC_URL + "/images/logoff.png"}
        />
        Log Off
      </button>
    </div>
  );
}

export default LogOff;
