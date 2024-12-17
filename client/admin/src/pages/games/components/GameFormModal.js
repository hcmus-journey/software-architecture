import { useState, useEffect } from "react";
import { loadAllTypes, editGame } from "../api";
import { useNotification } from "context/NotificationContext";
import { useModalContext } from "../context";
import { styled } from "@mui/material/styles";
import PropTypes from "prop-types";
import Modal from "@mui/material/Modal";
import Select from "@mui/material/Select";
import Box from "@mui/material/Box";
import Grid from "@mui/material/Grid";
import Typography from "@mui/material/Typography";
import Stack from "@mui/material/Stack";
import MenuItem from "@mui/material/MenuItem";
import CloudUploadIcon from "@mui/icons-material/CloudUpload";
import Button from "@mui/material/Button";
import CardMedia from "@mui/material/CardMedia";
import MDInput from "components/MDInput";
import MDBox from "components/MDBox";
import MDButton from "components/MDButton";

const VisuallyHiddenInput = styled("input")({
  clip: "rect(0 0 0 0)",
  clipPath: "inset(50%)",
  height: 1,
  overflow: "hidden",
  position: "absolute",
  bottom: 0,
  left: 0,
  whiteSpace: "nowrap",
  width: 1,
});

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

function AccountFormModal({ updateGames }) {
  const { modal, toggleModal, cloneGame, handleChange } = useModalContext();
  const [_, dispatch] = useNotification();
  const [types, setTypes] = useState([]);

  const handleSuccess = (msg) => {
    dispatch({ type: "SHOW_SUCCESS", payload: msg });
  };
  const handleError = (msg) => {
    dispatch({ type: "SHOW_ERROR", payload: msg });
  };
  const handleApply = async () => {
    const isMissingInfo = !cloneGame.title || !cloneGame.guide;
    if (isMissingInfo) {
      handleError("Vui lòng nhập đầy đủ thông tin game!");
      return;
    }
    const successMessage = "Chỉnh sửa thành công!";
    const errorMessage = "Chỉnh sửa thất bại!";
    try {
      const response = editGame(cloneGame);
      if (response.status === 200) {
        const updatedGame = { ...cloneGame };
        updateGames(updatedGame);
        handleSuccess(successMessage);
      } else {
        handleError(errorMessage);
      }
    } catch (error) {
      handleError("Đã xảy ra lỗi khi xử lý!");
    }
    toggleModal(false);
  };
  const fetchData = async () => {
    try {
      const [typesRes] = await Promise.all([loadAllTypes()]);
      setTypes(typesRes.data);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  return (
    <MDBox>
      <Modal
        open={modal}
        aria-labelledby="modal-modal-title"
        aria-describedby="modal-modal-description"
      >
        <Box sx={style}>
          <Grid container spacing={3}>
            <Grid
              item
              xs={12}
              md={12}
              display="flex"
              justifyContent="center"
              alignItems="center"
              flexDirection="column"
            >
              <CardMedia
                component="img"
                sx={{
                  width: "50%",
                  height: "auto",
                  maxHeight: "200px",
                  borderRadius: "2%",
                  border: "3px solid #fff",
                  boxShadow: "0 4px 12px rgba(0, 0, 0, 0.15)",
                  objectFit: "cover",
                }}
                image={cloneGame.image}
                alt="green iguana"
              />
              <Button
                sx={{ margin: "20px 10px 10px" }}
                component="label"
                role={undefined}
                variant="internal"
                tabIndex={-1}
                startIcon={<CloudUploadIcon />}
              >
                Upload files
                <VisuallyHiddenInput
                  type="file"
                  onChange={(e) => handleChange("image", e.target.files)}
                />
              </Button>
            </Grid>
            <Grid
              item
              xs={12}
              md={12}
              display="flex"
              justifyContent="flex-start"
              alignItems="center"
            >
              <Typography
                id="modal-modal-title"
                variant="h6"
                component="h2"
                sx={{
                  width: "110px",
                  color: "#323232",
                  fontWeight: 900,
                }}
              >
                Title
              </Typography>
              <MDInput
                fullWidth
                className="input"
                type="text"
                value={cloneGame.title}
                onChange={(e) => handleChange("title", e.target.value)}
              />
            </Grid>
            <Grid
              item
              xs={12}
              md={12}
              display="flex"
              justifyContent="flex-start"
              alignItems="center"
            >
              <Typography
                id="modal-modal-title"
                variant="h6"
                component="h2"
                sx={{
                  width: "110px",
                  color: "#323232",
                  fontWeight: 900,
                }}
              >
                Guide
              </Typography>

              <MDInput
                fullWidth
                multiline
                rows={3}
                className="input"
                type="text"
                value={cloneGame.guide}
                onChange={(e) => handleChange("guide", e.target.value)}
              />
            </Grid>
            <Grid
              item
              xs={12}
              md={7}
              display="flex"
              justifyContent="flex-start"
              alignItems="center"
            >
              <Typography
                id="modal-modal-title"
                variant="h6"
                component="h2"
                sx={{
                  width: "110px",
                  color: "#323232",
                  fontWeight: 900,
                }}
                mr={1.9}
              >
                Type
              </Typography>
              <Select
                value={cloneGame.type}
                onChange={(e) => handleChange("type", e.target.value)}
                sx={{ padding: "5px 2px", margin: "9px 0px 8px" }}
                inputProps={{ "aria-label": "Without label" }}
                className="input"
                fullWidth
              >
                {types.map((t) => (
                  <MenuItem key={t} value={t}>
                    {t.toUpperCase()}
                  </MenuItem>
                ))}
              </Select>
            </Grid>
            <Grid item xs={12} md={5} display="flex" justifyContent="flex-end" alignItems="center">
              <Typography
                mr={2}
                id="modal-modal-title"
                variant="h6"
                component="h2"
                sx={{
                  color: "#323232",
                  fontWeight: 900,
                }}
              >
                Tradable
              </Typography>
              <MDBox>
                <label className="switch">
                  <input
                    type="checkbox"
                    className="checkbox"
                    checked={cloneGame.tradable}
                    onChange={(e) => handleChange("tradable", e.target.checked)}
                  />
                  <div className="slider"></div>
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
    </MDBox>
  );
}
AccountFormModal.propTypes = {
  updateGames: PropTypes.func.isRequired,
};

export default AccountFormModal;
