import React from "react";
import $ from "jquery";
import "../../Css/LoginPage.css";
import RegisterUser from "../../Utils/RegisterUser";

function LoginPage() {
  const [isLogin, setIsLogin] = React.useState(false);

  return (
    <>
      {isLogin ? (
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
            onSubmit={async (e) => {
              e.preventDefault();
              let username = $("#username").val();
              let password = $("#password").val();

              let data = await fetch(
                "http://localhost:8080/signin/" + username + "/" + password
              );
              let response = await data.json();

              console.log(username, password, response);

              if (response.response === "invalid username or password") {
                alert("invalid username or password");
              } else {
                localStorage.setItem("jwt", response.response);
                // refresh page
                window.location.reload();
              }
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
                id="username"
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
                id="password"
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
            <button
              onClick={() => {}}
              className="btn btn-link"
              style={{
                color: "white",
                fontSize: "20px",
                fontWeight: "bold",
                marginTop: "10px",
                float: "left",
                padding: "10px",
                textAlign: "left",
                border: "none",
                borderRadius: "10px",
                textUnderlinePosition: "under"
              }}
            >
              Sign-Up
            </button>
          </div>
        </div>
      ) : (
        <div
          style={{
            position: "relative",
            paddingBottom: "100px"
         
          }}
          className="container RegisterUser-container"
        >
   <RegisterUser/>
        </div>
      )}
    </>
  );
}

export default LoginPage;
