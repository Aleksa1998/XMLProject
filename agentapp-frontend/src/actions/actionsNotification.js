import {
  GET_USER_NOTIFICATION_SETTINGS,
  GET_USER_NOTIFICATION_SETTINGS_ERROR,
  EDIT_NOTIFICATION_SETTINGS,
  EDIT_NOTIFICATION_SETTINGS_ERROR,
  CREATE_NOTIFICATION,
  CREATE_NOTIFICATION_ERROR,
  GET_NOTIFICATIONS_FOR_FOLLOWING,
  GET_NOTIFICATIONS_FOR_FOLLOWING_ERROR,
} from "../types/types";
import axios from "axios";

export const getUserNotificationSettings = (dto) => async (dispatch) => {
  debugger;
  try {
    const response = await axios.get(
      "http://localhost:44355/api/notificationOptions?",
      {
        params: {
          loggedUserId: dto.loggedUserId,
          notificationByUserId: dto.notificationByUserId,
        },
        headers: {
          "Access-Control-Allow-Origin": "*",
          Authorization: "Bearer " + sessionStorage.getItem("savedToken"),
        },
      }
    );
    dispatch({
      type: GET_USER_NOTIFICATION_SETTINGS,
      payload: response.data,
    });
  } catch (e) {
    dispatch({
      type: GET_USER_NOTIFICATION_SETTINGS_ERROR,
      payload: console.log(e),
    });
  }
};

export const editNotificationSettings =
  (notificationOptions) => async (dispatch) => {
    debugger;
    try {
      const response = await axios.put(
        "http://localhost:44355/api/notificationOptions",
        notificationOptions,
        {
          headers: {
            "Access-Control-Allow-Origin": "*",
            Authorization: "Bearer " + sessionStorage.getItem("savedToken"),
          },
        }
      );
      dispatch({
        type: EDIT_NOTIFICATION_SETTINGS,
        payload: response.data,
      });
      return true;
    } catch (e) {
      dispatch({
        type: EDIT_NOTIFICATION_SETTINGS_ERROR,
        payload: console.log(e),
      });
    }
  };

export const createNotification = (notification) => async (dispatch) => {
  debugger;
  try {
    const response = await axios.post(
      "http://localhost:44355/api/notifications",
      notification,
      {
        headers: {
          "Access-Control-Allow-Origin": "*",
          Authorization: "Bearer " + sessionStorage.getItem("savedToken"),
        },
      }
    );
    dispatch({
      type: CREATE_NOTIFICATION,
      payload: response.data,
    });
    return true;
  } catch (e) {
    dispatch({
      type: CREATE_NOTIFICATION_ERROR,
      payload: console.log(e),
    });
  }
};

export const getNotificationsForFollowing =
  (notificationUsers) => async (dispatch) => {
    debugger;
    try {
      const response = await axios.post(
        "http://localhost:44355/api/notifications/following",
        notificationUsers,
        {
          headers: {
            "Access-Control-Allow-Origin": "*",
            Authorization: "Bearer " + sessionStorage.getItem("savedToken"),
          },
        }
      );
      debugger;
      dispatch({
        type: GET_NOTIFICATIONS_FOR_FOLLOWING,
        payload: response.data,
      });
    } catch (e) {
      dispatch({
        type: GET_NOTIFICATIONS_FOR_FOLLOWING_ERROR,
        payload: console.log(e),
      });
    }
  };
