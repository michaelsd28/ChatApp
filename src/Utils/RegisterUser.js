import React from "react";
import $ from "jquery";

function RegisterUser({setLogin}) {
  // val id: String = UUID.randomUUID().toString(),
  // val name: String = "",
  // val password: String = "",
  // val userName: String = "",
  // var friends: List<FriendUser> = emptyList(),
  // var messages: List<Message> = emptyList(),
  // var groups: List<Group> = emptyList(),
  // var avatar: String = "",
  let user = {
    id: "",
    name: "",
    password: "",
    userName: "",
    friends: [],
    messages: [],
    groups: [],
    avatar: ""
  };

  let password2 = "";

  return (
    <>
      <div
        style={{
          position: "relative",
          top: "2rem",
          fontFamily: "monospace"
        }}
        className="registerContainer"
      >
        <div className="col-lg-12 col-xl-11">
          <div
            className="card text-black"
            style={{
              position: "relative",
              top: "2rem",
              backgroundColor: "#2D4263",
              color: "white"
            }}
          >
            <div className="card-body p-md-5">
              <div className="row justify-content-center">
                <div className="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">
                  <p className="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">
                    Sign up
                  </p>

                  <form className="mx-1 mx-md-4">
                    <div className="d-flex flex-row align-items-center mb-4">
                      <i className="fas fa-user fa-lg me-3 fa-fw"></i>
                      <div className="form-outline flex-fill mb-0">
                        <input
                          onChange={(e) => {
                            user.name = e.target.value;
                          }}
                          type="text"
                          id="form3Example1c register-name"
                          className="form-control"
                        />
                        <label className="form-label" for="form3Example1c">
                          Your Name
                        </label>
                      </div>
                    </div>

                    <div className="d-flex flex-row align-items-center mb-4">
                      <i className="fas fa-envelope fa-lg me-3 fa-fw"></i>
                      <div className="form-outline flex-fill mb-0">
                        <input
                          onKeyDown={(e) => {
                            user.userName = e.target.value;
                          }}
                          type="text"
                          id="form3Example3c register-user-name"
                          className="form-control"
                        />
                        <label className="form-label" for="form3Example3c">
                          Enter username
                        </label>
                      </div>
                    </div>

                    <div className="d-flex flex-row align-items-center mb-4">
                      <i className="fas fa-envelope fa-lg me-3 fa-fw"></i>
                      <div className="form-outline flex-fill mb-0">
                        <input
                          onChange={(e) => {
                            user.id = e.target.value;
                          }}
                          id="register-id"
                          type="number"
                          id="form3Example3c register-id"
                          className="form-control"
                        />
                        <label className="form-label" for="form3Example3c">
                          Enter ID
                        </label>
                      </div>
                    </div>

                    <div className="d-flex flex-row align-items-center mb-4">
                      <i className="fas fa-envelope fa-lg me-3 fa-fw"></i>
                      <div className="form-outline flex-fill mb-0">
                        <input
                          onChange={(e) => {
                            let reader = new FileReader();
                            reader.readAsDataURL(e.target.files[0]);
                            reader.onloadend = () => {
                              user.avatar = reader.result;
                   
                            };
                          }}
                          id="registerFile"
                          type="file"
                          id="form3Example3c"
                          className="form-control"
                        />
                        <label className="form-label" for="form3Example3c">
                          Avatar
                        </label>
                      </div>
                    </div>

                    <div className="d-flex flex-row align-items-center mb-4">
                      <i className="fas fa-lock fa-lg me-3 fa-fw"></i>
                      <div className="form-outline flex-fill mb-0">
                        <input
                          onChange={(e) => {
                            user.password = e.target.value;
                          }}
                          type="password"
                          id="form3Example4c register-password"
                          className="form-control"
                        />
                        <label className="form-label" for="form3Example4c">
                          Password
                        </label>
                      </div>
                    </div>

                    <div className="d-flex flex-row align-items-center mb-4">
                      <i className="fas fa-key fa-lg me-3 fa-fw"></i>
                      <div className="form-outline flex-fill mb-0">
                        <input
                          onChange={(e) => {
                            password2 = e.target.value;
                          }}
                          type="password"
                          id="form3Example4cd register-password2"
                          className="form-control"
                        />
                        <label className="form-label" for="form3Example4cd">
                          Repeat your password
                        </label>
                      </div>
                    </div>

                    <div className="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                      <button
                        onClick={async () => {
                          if (user.password === password2) {
                            let post = await fetch(
                              "http://localhost:8080/register",
                              {
                                method: "POST",
                                headers: { "Content-Type": "application/json" },
                                body: JSON.stringify(user)
                              }
                            );
                          } else {
                            alert("Passwords do not match");
                          }
                        }}
                        type="button"
                        className="btn btn-primary btn-lg"
                      >
                        Register
                      </button>
                      <button
                        onClick={() => {

                            setLogin(true);
                         
                          
                        }}
                        className="btn btn-dark"
                        style={{ padding: "0.5rem", marginLeft: "1rem" }}
                      >
                        Go to login
                      </button>
                    </div>
                  </form>
                </div>
                <div className="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">
                  <img
                    style={{
                      borderRadius: "25px"
                    }}
                    src="https://i.pinimg.com/originals/b0/ac/57/b0ac5722ccc9acf10bb560e0dfe420a6.png"
                    className="img-fluid"
                    alt="Sample image"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}

export default RegisterUser;
