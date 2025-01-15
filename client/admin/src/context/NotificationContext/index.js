import { createContext, useContext, useReducer, useMemo } from "react";
import PropTypes from "prop-types";

const NotificationContext = createContext();
NotificationContext.displayName = "NotificationContext";

function reducer(state, action) {
  switch (action.type) {
    case "SHOW_SUCCESS": {
      return { ...state, successSB: true, notificationMsg: action.payload };
    }
    case "SHOW_ERROR": {
      return { ...state, errorSB: true, notificationMsg: action.payload };
    }
    case "CLOSE_SUCCESS": {
      return { ...state, successSB: false };
    }
    case "CLOSE_ERROR": {
      return { ...state, errorSB: false };
    }
    default: {
      throw new Error(`Unhandled action type: ${action.type}`);
    }
  }
}

function NotificationProvider({ children }) {
  const initialState = {
    successSB: false,
    errorSB: false,
    notificationMsg: "",
  };

  const [state, dispatch] = useReducer(reducer, initialState);

  const value = useMemo(() => [state, dispatch], [state, dispatch]);

  return <NotificationContext.Provider value={value}>{children}</NotificationContext.Provider>;
}

NotificationProvider.propTypes = {
  children: PropTypes.node.isRequired,
};

function useNotification() {
  const context = useContext(NotificationContext);
  if (!context) {
    throw new Error("useNotification must be used within a NotificationProvider.");
  }
  return context;
}

export { NotificationProvider, useNotification };
