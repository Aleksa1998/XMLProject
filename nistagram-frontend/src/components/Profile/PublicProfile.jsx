import React, { useCallback, useEffect, useState } from "react";
import {
  getPostsByUserId,
  getAllImagesForProfile,
} from "../../actions/actions";
import PostModal from "../../components/Profile/PostModal";
import OptionsButton from "./OptionsButton";
import MyOptionsButton from "./MyOptionsButton";
import ProfileHeader from "./ProfileHeader";
import {
  Grid,
  Photo,
  GridControlBar,
  GridControlBarItem,
} from "react-instagram-ui-kit";
import { connect } from "react-redux";
import { compose } from "redux";
import { withRouter } from "react-router-dom";
import { getUserById, followProfile } from "../../actions/actionsUser";
import {
  getHighlights,
  getActiveStoriesForUser,
  getStoriesForUser,
  loadImagesForArchive,
} from "../../actions/actionsStory";
import ProfileStoryCard from "./ProfileStoryCard";
import { toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

function PublicProfile(props) {
  const [postId, setPostId] = useState("");
  const [showPostModal, setShowPostModal] = useState(false);
  const [username, setUsername] = useState("");
  const [followedById, setFollowedById] = useState(0);
  const [followingId, setFollowingId] = useState(0);
  const [shouldDisplayStories, setShouldDisplayStories] = useState(false);
  const user = props.user;
  const initialUser = {};
  const profilePosts = props.profilePosts;
  const highlights = props.highlights;

  useEffect(async () => {
    await props.getUserById(props.location.pathname.slice(9));
    await props.getPostsByUserId(props.location.pathname.slice(9));
    await props.getHighlights(props.location.pathname.slice(9));
    await props.getActiveStoriesForUser(props.location.pathname.slice(9));
    if (sessionStorage.getItem("userId") === props.location.pathname.slice(9)) {
      await props.getStoriesForUser();
      await props.loadImagesForArchive();
    }
  }, [props.location.pathname]);

  useEffect(() => {
    debugger;
    if (props.profilePosts !== undefined) getAllImages(props.profilePosts);
  }, [props.profilePosts]);

  const follow = () => {
    props.followProfile({
      FollowedById: sessionStorage.getItem("userId"),
      FollowingId: props.location.pathname.slice(9),
    });
    window.location = "/profile/" + props.location.pathname.slice(9);
  };

  const getAllImages = async (profilePosts) => {
    const paths = [];
    for (var i = 0; i < profilePosts.length; i++) {
      if (profilePosts[i].contentPath === undefined) {
        paths.push(profilePosts[i].contentPaths[0]);
      } else {
        paths.push(profilePosts[i].contentPath);
      }
    }
    await props.getAllImagesForProfile(paths);
  };

  const Posts = () => {
    var shouldDisplayPosts = false;
    if (props.location.pathname.slice(9) === sessionStorage.getItem("userId")) {
      shouldDisplayPosts = true;
    } else {
      if (user.isPrivate === false) {
        shouldDisplayPosts = true;
      } else {
        for (var i = 0; i < user.followers.length; i++) {
          if (user.followers[i].id === sessionStorage.getItem("userId")) {
            shouldDisplayPosts = true;
            break;
          }
        }
      }
    }
    if (props.location.pathname.slice(9) === sessionStorage.getItem("userId")) {
      setShouldDisplayStories(true);
    } else {
      if (user.isPrivate === false) {
        setShouldDisplayStories(true);
      } else {
        for (var i = 0; i < user.followers.length; i++) {
          if (user.followers[i].id === sessionStorage.getItem("userId")) {
            setShouldDisplayStories(true);
            break;
          }
        }
      }
    }
    if (shouldDisplayPosts === true) {
      if (profilePosts.length === 0) {
        return (
          <div className="text-center pt-5">
            <img src="/images/noposts.png" />
            <br />
            <h4>No Posts Yet</h4>
          </div>
        );
      }
    } else {
      return (
        <div className="text-center pt-5">
          <img src="/images/padlock.png" />
          <br />
          <h4>This Account Is Private</h4>
        </div>
      );
    }

    debugger;
    if (props.profileImages === undefined) {
      return null;
    }
    if (props.profileImages.length === 0) {
      return null;
    }
    if (shouldDisplayPosts === true) {
      return profilePosts.map((post, i) =>
        props.profileImages[i].contentType === "image/jpeg" ? (
          <Photo
            src={"data:image/jpg;base64," + props.profileImages[i].fileContents}
            onClick={() => displayModalPost(post)}
          />
        ) : (
          <video
            controls
            onClick={() => displayModalPost(post)}
            style={{ width: 367, height: 370 }}
            className="mb-3"
          >
            <source
              src={
                "data:video/mp4;base64," + props.profileImages[i].fileContents
              }
              type="video/mp4"
            ></source>
          </video>
        )
      );
    } else {
      return (
        <div className="text-center pt-5">
          <img src="/images/padlock.png" />
          <br />
          <h4>This Account Is Private</h4>
        </div>
      );
    }
  };

  const displayModalPost = (post) => {
    if (post != undefined) {
      setPostId(post.id);
      setUsername(post.registeredUser.username);
    }
    setShowPostModal(!showPostModal);
  };

  if (
    props.profilePosts === undefined ||
    user === undefined ||
    props.highlights === undefined ||
    props.stories === null
  ) {
    return null;
  }

  const DisplayFollowButton = () => {
    var display = true;
    debugger;
    for (var i = 0; i < user.followers.length; i++) {
      if (user.followers[i].id === sessionStorage.getItem("userId")) {
        display = false;
        break;
      }
    }
    if (display === true) {
      return (
        <button
          onClick={follow}
          style={{ float: "right" }}
          className="btn btn-block btn-primary btn-md mt-4 mb-4"
        >
          Follow
        </button>
      );
    } else {
      return "";
    }
  };

  return (
    <div>
      {showPostModal ? (
        <PostModal
          show={showPostModal}
          postId={postId}
          personPhoto={user.profilePicturePath}
          person={username}
          onShowChange={() => displayModalPost()}
        />
      ) : null}
      {props.location.pathname.slice(9) === sessionStorage.getItem("userId") ? (
        <MyOptionsButton />
      ) : (
        <OptionsButton />
      )}
      <ProfileHeader
        user={user}
        userid={user.id}
        postsCount={profilePosts.length}
        location={props.location.pathname.slice(9)}
      />
      {shouldDisplayStories ? (
        <ProfileStoryCard
          user={props.user}
          activeStories={props.stories}
          highlights={props.highlights}
        />
      ) : null}
      {props.location.pathname.slice(9) === sessionStorage.getItem("userId") ? (
        ""
      ) : (
        <DisplayFollowButton />
      )}
      <Grid>
        <GridControlBar>
          <GridControlBarItem isActive>𐄹 Posts</GridControlBarItem>
          <GridControlBarItem>웃 Tagged</GridControlBarItem>
        </GridControlBar>
        <Posts />
      </Grid>
    </div>
  );
}

const mapStateToProps = (state) => ({
  profilePosts: state.profilePosts,
  user: state.registeredUser,
  highlights: state.highlights,
  stories: state.activeStories,
  profileImages: state.profileImages,
});

export default compose(
  withRouter,
  connect(mapStateToProps, {
    getPostsByUserId,
    getUserById,
    followProfile,
    getHighlights,
    getActiveStoriesForUser,
    getStoriesForUser,
    loadImagesForArchive,
    getAllImagesForProfile,
  })
)(PublicProfile);
