import React, { Component } from "react";
import MyProfile from "../components/Profile/MyProfile";
import Layout from "../layouts/Layout";

class ProfilePage extends Component {
  render() {
    return (
      <Layout>
        <MyProfile />
      </Layout>
    );
  }
}

export default ProfilePage;