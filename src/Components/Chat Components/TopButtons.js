import React from "react";

function TopButtons() {
  return (
    <div className="col-lg-6 hidden-sm text-right">
      <a href="javascript:void(0);" className="btn btn-outline-secondary">
        <i className="fa fa-camera"></i>
      </a>
      <a href="javascript:void(0);" className="btn btn-outline-primary">
        <i className="fa fa-image"></i>
      </a>
      <a href="javascript:void(0);" className="btn btn-outline-info">
        <i className="fa fa-cogs"></i>
      </a>
      <a href="javascript:void(0);" className="btn btn-outline-warning">
        <i className="fa fa-question"></i>
      </a>
    </div>
  );
}

export default TopButtons;
