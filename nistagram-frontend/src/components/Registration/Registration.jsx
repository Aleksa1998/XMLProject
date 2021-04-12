import React, { Component } from "react";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker-cssmodules.css";

class Registration extends Component {
  state = {
    id: 1,
    name: "",
    email: "",
    phoneNumber: "",
    dateOfBirth: "",
    gender: "",
    username: "",
    bio: "",
    webSite: "",
    password: "",
    repeatPassword: ""
  };

  render() {
    return (
      <React.Fragment>
        <main className="main pt-0 pb-0" style={{ backgroundColor: "#4da3ff" }}>
          <div className="wrap bg-white">
            <div className="text-center pt-5">
              <img
                alt=""
                width="100"
                height="100"
                src="/images/iconfinder_00-ELASTOFONT-STORE-READY_user-circle_2703062.png"
              />
            </div>
            <div className="mt-5">
              <div className="d-inline-flex w-50">
                <div class="form-group w-100 pr-5">
                  <label for="firstName">Name:</label>
                  <input
                    type="text"
                    name="name"
                    value={this.state.name}
                    onChange={this.handleChange}
                    class="form-control"
                    id="name"
                    placeholder="Enter name"
                  />
                </div>
              </div>
              <div className="d-inline-flex w-50">
                <div class="form-group w-100 pr-5">
                  <label for="lastName">Email:</label>
                  <input
                    type="text"
                    name="email"
                    value={this.state.email}
                    onChange={this.handleChange}
                    class="form-control"
                    id="email"
                    placeholder="Enter email"
                  />
                </div>
              </div>
            </div>
            <div className="mt-5">
              <div className="d-inline-flex w-50">
                <div class="form-group w-100 pr-5">
                  <label for="dateofbirth">Date of birth:</label>
                  <div className="d-block w-100">
                    <DatePicker
                      className="form-control w-100"
                      id="dateofbirth"
                      name="dueDate"
                      dateFormat="dd/MM/yyyy"
                      selected={this.state.dateOfBirth}
                      maxDate={new Date()}
                      onChange={(e) => this.handleChangeDate(e)}
                    />
                  </div>
                </div>
              </div>
              <div className="d-inline-flex w-50">
                <div class="form-group w-100 pr-5">
                  <label for="telephone">Phone number:</label>
                  <input
                    type="text"
                    name="phoneNumber"
                    value={this.state.phoneNumber}
                    onChange={this.handleChange}
                    class="form-control"
                    id="telephone"
                    placeholder="Enter telephone number"
                  />
                </div>
              </div>
            </div>
            <div className="mt-5">
              <div className="d-inline-flex w-50">
                <div class="form-group w-100 pr-5">
                  <label for="firstName">Username:</label>
                  <input
                    type="text"
                    name="username"
                    value={this.state.username}
                    onChange={this.handleChange}
                    class="form-control"
                    id="username"
                    placeholder="Enter username"
                  />
                </div>
              </div>
              <div className="d-inline-flex w-50">
                <div class="form-group w-100 pr-5">
                  <label for="lastName">Gender:</label>
                  <select
                    value={this.state.gender}
                    class="form-control"
                    onChange={this.handleChange}
                    name="gender"
                  >
                    <option value=""> </option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                  </select>
                </div>
              </div>
            </div>
            <div className="mt-5">
              <div className="d-inline-flex w-50">
                <div class="form-group w-100 pr-5">
                  <label for="firstName">Password:</label>
                  <input
                    type="password"
                    name="password"
                    value={this.state.password}
                    onChange={this.handleChange}
                    class="form-control"
                    id="password"
                    placeholder="Enter password"
                  />
                </div>
              </div>
              <div className="d-inline-flex w-50">
                <div class="form-group w-100 pr-5">
                  <label for="lastName">Repeat password:</label>
                  <input
                    type="password"
                    name="repeatPassword"
                    value={this.state.repeatPassword}
                    onChange={this.handleChange}
                    class="form-control"
                    id="repeatPassword"
                    placeholder="Repeat password"
                  />
                </div>
              </div>
            </div>
            <div className="mt-5">
              <div className="d-inline-flex w-50">
                <div class="form-group w-100 pr-5">
                  <label for="firstName">Biography:</label>
                  <textarea
                    name="bio"
                    value={this.state.bio}
                    onChange={this.handleChange}
                    cols="40"
                    rows="5"
                    class="form-control"
                    placeholder="Enter biography"
                  ></textarea>
                </div>
              </div>
              <div className="d-inline-flex w-50">
                <div class="form-group w-100 pr-5">
                  <label for="lastName">Web site:</label>
                  <input
                    type="text"
                    name="webSite"
                    value={this.state.webSite}
                    onChange={this.handleChange}
                    class="form-control"
                    id="webSite"
                    placeholder="Enter webSite"
                  />
                </div>
              </div>
            </div>
            <div className="mt-5 pb-5">
              <button className="btn btn-lg btn-primary btn-block">
                Register
              </button>
            </div>
          </div>
        </main>
      </React.Fragment>
    );
  }

  handleChange = (event) => {
    debugger;
    const { name, value, type, checked } = event.target;
    type === "checkbox"
      ? this.setState({
          [name]: checked,
        })
      : this.setState({
          [name]: value,
        });
  };

  handleChangeDate = (e) => {
    this.setState({
      dateOfBirth: e,
    });
  };
}

export default Registration;
