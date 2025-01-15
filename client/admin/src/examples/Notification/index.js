import { useNotification } from "context/NotificationContext";
import MDSnackbar from "components/MDSnackbar";

function Notification() {
  const [state, dispatch] = useNotification();

  const { successSB, errorSB, notificationMsg } = state;

  const closeSuccessSB = () => dispatch({ type: "CLOSE_SUCCESS" });
  const closeErrorSB = () => dispatch({ type: "CLOSE_ERROR" });

  return (
    <>
      <MDSnackbar
        color="success"
        icon="check"
        title="Success Notification"
        content={notificationMsg}
        dateTime=""
        open={successSB}
        onClose={closeSuccessSB}
        close={closeSuccessSB}
        bgWhite
      />
      <MDSnackbar
        color="error"
        icon="warning"
        title="Error Notification"
        content={notificationMsg}
        dateTime=""
        open={errorSB}
        onClose={closeErrorSB}
        close={closeErrorSB}
        bgWhite
      />
    </>
  );
}

export default Notification;
