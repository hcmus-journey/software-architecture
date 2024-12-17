import { useModalContext } from "../context";
import MDButton from "components/MDButton";
import Icon from "@mui/material/Icon";

function AddNewButton() {
  const { toggleModal, changeCloneAccount } = useModalContext();
  return (
    <MDButton
      variant="gradient"
      color="success"
      onClick={() => {
        changeCloneAccount(null);
        toggleModal(true);
      }}
    >
      <Icon sx={{ fontWeight: "bold", mt: -0.05 }}>add</Icon>
      &nbsp;Add New
    </MDButton>
  );
}

export default AddNewButton;
