import React, { Component } from "react";
import Stories from "react-insta-stories";
import { Modal, ModalBody } from "reactstrap";
import {
  getStoriesForModal,
  loadImagesStory,
} from "../../actions/actionsStory";
import { connect } from "react-redux";
import "../../css/story.css";
import TaggedUsersProfileStoryModal from "./TaggedUsersProfileStoryModal";

class ProfileStoryModal extends Component {
  state = {
    showProfileStoryModal: this.props.show,
    showTaggedUsersModal: false,
    users: [],
  };

  async componentDidMount() {
    await this.props.getStoriesForModal(this.props.user);
    await this.props.loadImagesStory(this.createImagesList(this.props.stories));
  }

  render() {
    if (this.props.stories === undefined || this.props.images === undefined)
      return null;
    debugger;
    const stories = [];
    this.props.stories.forEach((story, i) => {
      stories.push({
        url: "data:image/jpg;base64," + this.props.images[i],
        duration: 1000 * story.duration,
        header: {
          heading:
            story.registeredUser.firstName +
            " " +
            story.registeredUser.lastName,
          subheading: `Posted ${this.timeSince(story.timeStamp)} ago`,
          profileImage: "data:image/jpg;base64," + this.props.profileImage,
        },
        seeMore: ({ close }) => {
          return (
            <div>
              <div
                onClick={close}
                style={{
                  bottom: 0,
                  position: "absolute",
                  zIndex: 10,
                  width: "100%",
                  backgroundColor: "black",
                  opacity: "50%",
                  color: "white",
                  height: "150px",
                }}
              ></div>
              <div className="story-footer-description">
                {story.description}
              </div>
              <div className="story-footer-hashtag">
                {this.convertHashtagsToString(story.hashTags)}
              </div>
              <div className="story-footer-bottom">
                <button
                  className="btn btn-sm btn-primary"
                  onClick={() => this.displayModalStory(story.taggedUsers)}
                >
                  Tagged users:
                </button>
              </div>
            </div>
          );
        },
      });
    });
    return (
      <Modal
        style={{
          maxWidth: "450px",
          width: "450px",
          maxHeight: "700px",
          width: "700px",
          borderRadius: "15px",
        }}
        className="text-center"
        isOpen={this.state.showProfileStoryModal}
        toggle={this.toggle.bind(this)}
        centered={true}
        backdropClassName="story-modal-backdrop"
      >
        {this.state.showTaggedUsersModal ? (
          <TaggedUsersProfileStoryModal
            show={this.state.showTaggedUsersModal}
            taggedUsers={this.state.users}
            onShowChange={this.displayModalStory.bind(this)}
          />
        ) : null}
        <ModalBody
          className="story-modal-body"
          style={{ padding: "2px !important" }}
        >
          <Stories
            keyboardNavigation
            width="100%"
            height="670px"
            stories={stories}
            onAllStoriesEnd={(s, st) => this.toggle()}
            storyStyles={{ height: "670px" }}
          />
        </ModalBody>
      </Modal>
    );
  }

  timeSince(date) {
    var correctDate = new Date(Date.parse(date));
    correctDate.setHours(correctDate.getHours() - 2);
    var seconds = Math.floor(
      (new Date() - new Date(Date.parse(correctDate))) / 1000
    );

    var interval = seconds / 31536000;

    if (interval > 1) {
      return Math.floor(interval) + " years";
    }
    interval = seconds / 2592000;
    if (interval > 1) {
      return Math.floor(interval) + " months";
    }
    interval = seconds / 86400;
    if (interval > 1) {
      return Math.floor(interval) + " days";
    }
    interval = seconds / 3600;
    if (interval > 1) {
      return Math.floor(interval) + " hours";
    }
    interval = seconds / 60;
    if (interval > 1) {
      return Math.floor(interval) + " minutes";
    }
    return Math.floor(seconds) + " seconds";
  }

  convertHashtagsToString(hashtags) {
    debugger;
    var temp = [...hashtags];
    var text = temp[0];
    temp.shift();
    temp.forEach((element) => {
      text += " " + element;
    });
    return text;
  }

  createImagesList() {
    var images = [];
    this.props.stories.forEach((element) => {
      images.push(element.contentPath);
    });
    return images;
  }

  toggle() {
    debugger;
    this.setState({ showPostModal: false });
    this.props.onShowChange();
  }

  displayModalStory(users) {
    debugger;
    this.setState({
      showTaggedUsersModal: !this.state.showTaggedUsersModal,
      users: users,
    });
  }
}

const mapStateToProps = (state) => ({
  stories: state.storiesForModal,
  images: state.storyImages,
});

export default connect(mapStateToProps, {
  getStoriesForModal,
  loadImagesStory,
})(ProfileStoryModal);
