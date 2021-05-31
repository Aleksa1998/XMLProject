import {
  GET_POSTS_BY_USER_ID,
  GET_POSTS_BY_USER_ID_ERROR,
  GET_POST,
  GET_POST_ERROR,
  LOAD_IMAGE,
  LOAD_IMAGE_ERROR,
  SAVE_POST,
  SAVE_POST_ERROR,
} from "../types/types";
import axios from "axios";

export const getPostsByUserId = (id) => async (dispatch) => {
  try {
    debugger;
    const response = await axios.get(
      "https://localhost:44355/api/posts/users/" + id,
      {
        headers: { "Access-Control-Allow-Origin": "*" },
      }
    );
    debugger;
    dispatch({
      type: GET_POSTS_BY_USER_ID,
      payload: response.data,
    });
  } catch (e) {
    dispatch({
      type: GET_POSTS_BY_USER_ID_ERROR,
      payload: console.log(e),
    });
  }
};

export const getPost = (id) => async (dispatch) => {
  try {
    debugger;
    const response = await axios
      .get("https://localhost:44355/api/posts/" + id, {
        headers: { "Access-Control-Allow-Origin": "*" },
      })
      .then(function (response) {
        debugger;
        dispatch({
          type: GET_POST,
          payload: response.data,
        });
        const response2 = axios
          .get(
            "https://localhost:44355/api/posts/contents/" +
              response.data.contentPath,
            {
              headers: {
                "Access-Control-Allow-Origin": "*",
              },
            }
          )
          .then(function (response2) {
            debugger;
            dispatch({
              type: LOAD_IMAGE,
              payload: response2.data.fileContents,
            });
          });
      });
  } catch (e) {
    dispatch({
      type: GET_POST_ERROR,
      payload: console.log(e),
    });
  }
};

export const loadImage = (path) => async (dispatch) => {
  try {
    debugger;
    const response = await axios.get(
      "https://localhost:44355/api/posts/contents/" + path,
      {
        headers: { "Access-Control-Allow-Origin": "*" },
      }
    );
    debugger;
    dispatch({
      type: LOAD_IMAGE,
      payload: response.data.fileContents,
    });
  } catch (e) {
    dispatch({
      type: LOAD_IMAGE_ERROR,
      payload: console.log(e),
    });
  }
};

export const savePost = (post) => async (dispatch) => {
  try {
    debugger;
    const response = await axios.post(
      "https://localhost:44355/api/posts/",
      post,
      {
        headers: { "Access-Control-Allow-Origin": "*" },
      }
    );
    debugger;
    dispatch({
      type: SAVE_POST,
      payload: response.data,
    });
  } catch (e) {
    dispatch({
      type: SAVE_POST_ERROR,
      payload: console.log(e),
    });
  }
};
