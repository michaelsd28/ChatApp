import React from "react";
import LogOff from "../../Utils/LogOff";
import RemoveFriend from "../../Utils/RemoveFriend";

function TopButtons() {
  return (
    <div className="col-lg-6 hidden-sm text-right">
      <div className="d-flex flex-row-reverse">
        <LogOff />
        <RemoveFriend />
      </div>
    </div>
  );
}

export default TopButtons;
