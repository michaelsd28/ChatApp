import React from "react";
import "../../Css/LoginPage.css";

function LoginPage() {
  return (
    <>
      <div id="logingPage" className="loginBox">
        <img
          className="user"
          src="https://i.ibb.co/yVGxFPR/2.png"
          height="100px"
          width="100px"
        />
        <h3>Sign in here</h3>
        <form
          className="form-group"
          onSubmit={(e) => {
            e.preventDefault();
          }}
        >
          <div className="inputBox">
            <input
              style={{
                borderRadius: "10px",
                border: "1px solid #ccc",
                paddingLeft: "10px",
                paddingRight: "10px",
                paddingTop: "5px",
                paddingBottom: "5px",
                width: "100%",
                height: "40px"
              }}
              id="uname"
              type="text"
              name="Username"
              placeholder="Username"
            />
            <input
              style={{
                borderRadius: "10px",
                border: "1px solid #ccc",
                paddingLeft: "10px",
                paddingRight: "10px",
                paddingTop: "5px",
                paddingBottom: "5px",
                width: "100%",
                height: "40px"
              }}
              id="pass"
              type="password"
              name="Password"
              placeholder="Password"
            />
          </div>
          <input type="submit" name="" value="Login" />
        </form>{" "}
        <a href="#">
          Forget Password
          <br />{" "}
        </a>
        <div className="text-center">
          <p
            style={{
              color: "white",
              fontSize: "20px",
              fontWeight: "bold",
              marginTop: "10px",
              float: "left"
            }}
          >
            Sign-Up
          </p>
        </div>
      </div>
    </>
  );
}

export default LoginPage;
