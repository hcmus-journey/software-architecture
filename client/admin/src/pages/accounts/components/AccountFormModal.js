import PropTypes from "prop-types";
import { useState, useEffect } from "react";
import { addNewAccount, editAccount, loadAllRoles } from "../api";
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
import toggleStyle from "../accounts.module.css";

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

  const handleSuccess = (msg) => {
    dispatch({ type: "SHOW_SUCCESS", payload: msg });
  };
  const handleError = (msg) => {
    dispatch({ type: "SHOW_ERROR", payload: msg });
  };
  const handleApply = async () => {
    const isAdding = !cloneAccount.hasOwnProperty("id");
    const isMissingInfo =
      !cloneAccount.name ||
      !cloneAccount.username ||
      !cloneAccount.email ||
      !cloneAccount.phone ||
      isAdding
        ? !cloneAccount.password
        : false;
    if (isMissingInfo) {
      handleError("Vui lòng nhập đầy đủ thông tin người dùng!");
      return;
    }
    const successMessage = isAdding
      ? "Thêm thành công người dùng mới!"
      : "Chỉnh sửa thành công tài khoản!";
    const errorMessage = isAdding ? "Thêm người dùng mới thất bại!" : "Chỉnh sửa thất bại!";
    try {
      const response = isAdding ? addNewAccount(cloneAccount) : editAccount(cloneAccount);
      if (response.status === 200) {
        const updatedAcc = isAdding ? { ...cloneAccount, id: response.id } : { ...cloneAccount };
        updateAccount(updatedAcc);
        handleSuccess(successMessage);
      } else {
        handleError(errorMessage);
      }
    } catch (error) {
      handleError("Đã xảy ra lỗi khi xử lý tài khoản!");
    }
    toggleModal(false);
  };
  const fetchData = async () => {
    try {
      const [rolesRes] = await Promise.all([loadAllRoles()]);
      setRoles(rolesRes.data);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  useEffect(() => {
    fetchData();
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
              {cloneAccount.hasOwnProperty("id") ? "Edit Account" : "Add New Account"}
            </MDTypography>
          </MDBox>
        </MDBox>
        <Grid container spacing={3}>
          {[
            { label: "Name", key: "name", type: "text" },
            { label: "Username", key: "username", type: "text" },
            { label: "Email", key: "email", type: "email" },
            { label: "Phone", key: "phone", type: "text" },
            { label: "Password", key: "password", type: "password" },
          ].map(({ label, key, type }) => (
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
                fullWidth
                className={toggleStyle.input}
                type={type}
                value={cloneAccount[key]}
                onChange={(e) => handleChange(key, e.target.value)}
              />
            </Grid>
          ))}
          <Grid item xs={12} md={7} display="flex" justifyContent="flex-start" alignItems="center">
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
              sx={{ padding: "12px 2px", margin: "9px 0px 8px" }}
              className={toggleStyle.input}
              fullWidth
            >
              {roles.map((r) => (
                <MenuItem key={r} value={r}>
                  {r.toUpperCase()}
                </MenuItem>
              ))}
            </Select>
          </Grid>
          <Grid item xs={12} md={5} display="flex" justifyContent="flex-end" alignItems="center">
            <Typography
              mr={2}
              variant="h6"
              sx={{
                color: "#323232",
                fontWeight: 900,
              }}
            >
              Active
            </Typography>
            <MDBox>
              <label className={toggleStyle.switch}>
                <input
                  type="checkbox"
                  className={toggleStyle.checkbox}
                  checked={cloneAccount.status.toUpperCase() === "ACTIVE" ? true : false}
                  onChange={(e) =>
                    handleChange("status", e.target.checked === true ? "ACTIVE" : "INACTIVE")
                  }
                />
                <div className={toggleStyle.slider}></div>
              </label>
            </MDBox>
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
