import { useModalContext } from "../context";
import MDButton from "components/MDButton";
import Icon from "@mui/material/Icon";

function AddNewButton() {
  const { toggleModal, changeCloneQuiz, toggleIsAdding } = useModalContext();
  return (
    <MDButton
      variant="gradient"
      color="success"
      onClick={() => {
        changeCloneQuiz(null);
        toggleModal(true);
        toggleIsAdding(true);
      }}
    >
      <Icon sx={{ fontWeight: "bold", mt: -0.05 }}>add</Icon>
      &nbsp;Add New
    </MDButton>
  );
}

export default AddNewButton;
