import PropTypes from "prop-types";
import { useState, useEffect } from "react";
import { editAccount, getAllRoles, getAllStatus } from "../api";
import { useNotification } from "context/NotificationContext";
import { useModalContext } from "../context";
import Modal from "@mui/material/Modal";
import Select from "@mui/material/Select";
import Box from "@mui/material/Box";
import Grid from "@mui/material/Grid";
import Typography from "@mui/material/Typography";
import Stack from "@mui/material/Stack";
import MenuItem from "@mui/material/MenuItem";
import MDInput from "components/MDInput";
import MDBox from "components/MDBox";
import MDButton from "components/MDButton";
import MDTypography from "components/MDTypography";

const style = {
  position: "absolute",
  top: "50%",
  left: "50%",
  transform: "translate(-50%, -50%)",
  width: 600,
  bgcolor: "#d8d8d8",
  borderRadius: "5px",
  border: "2px solid #323232",
  boxShadow: "4px 4px #323232",
  p: 4,
};

function AccountFormModal({ updateAccount }) {
  const { modal, toggleModal, cloneAccount, handleChange } = useModalContext();
  const [_, dispatch] = useNotification();
  const [roles, setRoles] = useState([]);
  const [status, setStatus] = useState([]);

  const handleSuccess = (msg) => {
    dispatch({ type: "SHOW_SUCCESS", payload: msg });
  };
  const handleError = (msg) => {
    dispatch({ type: "SHOW_ERROR", payload: msg });
  };
  const handleApply = async () => {
    const isMissingInfo = !cloneAccount.username;
    if (isMissingInfo) {
      handleError("Please fill in all the fields!");
      return;
    }
    try {
      const isSuccess = await editAccount(cloneAccount);
      if (isSuccess) {
        const updatedAcc = { ...cloneAccount };
        updateAccount(updatedAcc);
        handleSuccess("Edit the account successful!");
      } else {
        handleError("Fail to edit the account!");
      }
    } catch (error) {
      handleError("Something wrong has happened!");
    }
    toggleModal(false);
  };
  const loadData = () => {
    setRoles(getAllRoles());
    setStatus(getAllStatus());
  };

  useEffect(() => {
    loadData();
  }, []);

  return (
    <Modal
      open={modal}
      aria-labelledby="modal-modal-title"
      aria-describedby="modal-modal-description"
    >
      <Box sx={style}>
        <MDBox display="flex" justifyContent="center" alignItems="center" pb={4} px={3}>
          <MDBox>
            <MDTypography
              variant="h5"
              sx={{
                color: "#323232",
                fontWeight: 900,
                fontSize: 25,
              }}
            >
              Edit Account
            </MDTypography>
          </MDBox>
        </MDBox>
        <Grid container spacing={3}>
          {[{ label: "Username", key: "username", type: "text" }].map(({ label, key, type }) => (
            <Grid
              key={key}
              item
              xs={12}
              display="flex"
              justifyContent="flex-start"
              alignItems="center"
            >
              <Typography
                variant="h6"
                sx={{
                  width: "110px",
                  color: "#323232",
                  fontWeight: 900,
                }}
              >
                {label}
              </Typography>
              <MDInput
                placeholder="Type here..."
                fullWidth
                className="input"
                value={cloneAccount[key]}
              />
            </Grid>
          ))}
          <Grid item xs={12} md={6} display="flex" justifyContent="flex-start" alignItems="center">
            <Typography
              variant="h6"
              sx={{
                width: "110px",
                color: "#323232",
                fontWeight: 900,
              }}
              mr={1.9}
            >
              Role
            </Typography>
            <Select
              value={cloneAccount.role}
              onChange={(e) => handleChange("role", e.target.value)}
              sx={{ padding: "5px 2px", margin: "9px 0px 8px" }}
              className="input"
              fullWidth
            >
              {roles.map((r) => (
                <MenuItem key={r} value={r}>
                  {r.toUpperCase()}
                </MenuItem>
              ))}
            </Select>
          </Grid>
          <Grid item xs={12} md={6} display="flex" justifyContent="flex-start" alignItems="center">
            <Typography
              variant="h6"
              sx={{
                width: "110px",
                color: "#323232",
                fontWeight: 900,
              }}
              mr={1.9}
            >
              Status
            </Typography>
            <Select
              value={cloneAccount.status}
              onChange={(e) => handleChange("status", e.target.value)}
              sx={{ padding: "5px 2px", margin: "9px 0px 8px" }}
              className="input"
              fullWidth
            >
              {status.map((s) => (
                <MenuItem key={s} value={s}>
                  {s.toUpperCase()}
                </MenuItem>
              ))}
            </Select>
          </Grid>
        </Grid>
        <Stack
          direction="row"
          spacing={1}
          sx={{
            justifyContent: "flex-end",
            alignItems: "center",
          }}
          mt={5}
        >
          <MDButton
            variant="gradient"
            color="error"
            onClick={() => {
              toggleModal(false);
            }}
            mr={2}
          >
            Cancel
          </MDButton>
          <MDButton variant="gradient" color="dark" onClick={handleApply}>
            Apply
          </MDButton>
        </Stack>
      </Box>
    </Modal>
  );
}
AccountFormModal.propTypes = {
  updateAccount: PropTypes.func.isRequired,
};

export default AccountFormModal;
