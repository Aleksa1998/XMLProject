import {
  GET_ITEMS,
  CREATE_ITEM,
  GET_ITEM_BY_ID,
  LOAD_IMAGE,
  EDIT_ITEM,
  DELETE_ITEM,
  GET_LOGGED_USER,
  REGISTER_USER,
  BUY_ITEM,
} from "../types/types";

const initialState = {
  items: [],
  item: {},
  loadedImage: "",
  loggedUser: {},
  registeredUser: {},
};

function reducer(state = initialState, action) {
  switch (action.type) {
    case GET_ITEMS:
      return {
        ...state,
        items: action.payload,
      };
    case CREATE_ITEM:
      return {
        ...state,
      };
    case GET_ITEM_BY_ID:
      return {
        ...state,
        item: action.payload,
      };
    case LOAD_IMAGE:
      return {
        ...state,
        loadedImage: action.payload,
      };
    case EDIT_ITEM:
      return {
        ...state,
      };
    case DELETE_ITEM:
      return {
        ...state,
      };
    case GET_LOGGED_USER:
      return {
        ...state,
        loggedUser: action.payload,
      };
    case REGISTER_USER:
      return {
        ...state,
        registeredUser: action.payload,
      };
    case BUY_ITEM:
      return {
        ...state,
      };
    default:
      return state;
  }
}

export default reducer;