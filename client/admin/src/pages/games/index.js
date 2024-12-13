/**
=========================================================
* Material Dashboard 2 React - v2.2.0
=========================================================

* Product Page: https://www.creative-tim.com/product/material-dashboard-react
* Copyright 2023 Creative Tim (https://www.creative-tim.com)

Coded by www.creative-tim.com

 =========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
*/
import { useState, useEffect, Fragment } from "react";

import DashboardLayout from "examples/LayoutContainers/DashboardLayout";
import DashboardNavbar from "examples/Navbars/DashboardNavbar";
import IconButton from "@mui/material/IconButton";
import Footer from "examples/Footer";
import Tabs from "@mui/material/Tabs";
import Tab from "@mui/material/Tab";
import MDBox from "components/MDBox";
import Grid from "@mui/material/Grid";
import ComplexStatisticsCard from "examples/Cards/StatisticsCards/ComplexStatisticsCard";
import ReportsBarChart from "examples/Charts/BarCharts/ReportsBarChart";
import Card from "@mui/material/Card";
import MDTypography from "components/MDTypography";
import MDButton from "components/MDButton";
import Icon from "@mui/material/Icon";
import Box from "@mui/material/Box";
import Chip from "@mui/material/Chip";
import CardMedia from "@mui/material/CardMedia";
import CardActionArea from "@mui/material/CardActionArea";
import SwipeableDrawer from "@mui/material/SwipeableDrawer";
import CardContent from "@mui/material/CardContent";
import Button from "@mui/material/Button";
import List from "@mui/material/List";
import Divider from "@mui/material/Divider";
import ListItem from "@mui/material/ListItem";
import ListItemButton from "@mui/material/ListItemButton";
import ListItemIcon from "@mui/material/ListItemIcon";
import ListItemText from "@mui/material/ListItemText";
import InboxIcon from "@mui/icons-material/MoveToInbox";
import MailIcon from "@mui/icons-material/Mail";
import DataTable from "examples/Tables/DataTable";
import Pagination from "@mui/material/Pagination";
import authorsTableData from "./authorsTableData";
import Stack from "@mui/material/Stack";
import Grid2 from "@mui/material/Unstable_Grid2";
import MDInput from "components/MDInput";
import Typography from "@mui/material/Typography";
import Modal from "@mui/material/Modal";
import { pink } from "@mui/material/colors";
import FormGroup from "@mui/material/FormGroup";
import FormControlLabel from "@mui/material/FormControlLabel";
import Checkbox from "@mui/material/Checkbox";
import MenuItem from "@mui/material/MenuItem";
import FormControl from "@mui/material/FormControl";
import Select from "@mui/material/Select";
import InputLabel from "@mui/material/InputLabel";
import toggleStyle from "./accounts.module.css";
import MDPagination from "components/MDPagination";
import DefaultProjectCard from "examples/Cards/ProjectCards/DefaultProjectCard";
import { styled } from "@mui/material/styles";
import CloudUploadIcon from "@mui/icons-material/CloudUpload";

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

const label = { inputProps: { "aria-label": "Checkbox demo" } };

function Games() {
  const [campaign, setCampaign] = useState("Mùa hè xanh");
  const handleSetCampaign = (event, newValue) => setCampaign(event.target.value);
  const [canFilter, setCanFilter] = useState(false);
  const { columns, rows } = authorsTableData();

  const toggleDrawer = (open) => (event) => {
    if (event && event.type === "keydown" && (event.key === "Tab" || event.key === "Shift")) {
      return;
    }
    setCanFilter(open);
  };
  const [canAdd, setCanAdd] = useState(false);
  const enableAdd = () => setCanAdd(true);
  const unenableAdd = () => setCanAdd(false);

  const [accountTabValue, setAccountTabValue] = useState(0);
  const handleSetAccountTabValue = (event, newValue) => setAccountTabValue(newValue);

  return (
    <DashboardLayout>
      <DashboardNavbar />
      <MDBox pt={2} pb={3} sx={{ minHeight: "80vh" }}>
        <Grid container spacing={3} p={1}>
          <Grid item xs={12} md={3}>
            <Card sx={{ padding: "0px" }}>
              <CardActionArea
                sx={{
                  display: "flex",
                  justifyContent: "center",
                  alignItems: "center",
                  flexDirection: "column",
                }}
              >
                <CardMedia
                  component="img"
                  sx={{
                    width: "88%",
                    height: "auto",
                    objectFit: "cover",
                    boxShadow: "0 4px 12px rgba(0, 0, 0, 0.2)",
                  }}
                  image="https://bit.ly/3Hlw1MQ"
                  alt="green iguana"
                />
                <CardContent sx={{ width: "88%", padding: "15px 0px 25px" }}>
                  <Typography gutterBottom variant="h5" component="div">
                    Realtime Quiz
                  </Typography>
                  <Typography variant="body2" sx={{ color: "gray", fontSize: "15px" }}>
                    Lizards are a widespread group of squamate reptiles, with over 6,000 species,
                    ranging across all continents except Antarctica
                  </Typography>
                  <Box sx={{ mt: 2, display: "flex", flexWrap: "wrap", gap: 1 }}>
                    <Chip
                      label="Quiz"
                      sx={{
                        backgroundColor: "rgba(128, 0, 128, 0.1)", // Màu nền tương tự bg-purple-100
                        color: "purple",
                        fontSize: "0.75rem", // text-xs
                        borderRadius: "9999px", // rounded-full
                        paddingX: 1.25, // px-2.5
                        paddingY: 0.5, // py-0.5
                      }}
                    />
                    <Chip
                      label="Collectable"
                      sx={{
                        backgroundColor: "rgba(128, 0, 128, 0.1)", // Màu nền tương tự bg-purple-100
                        color: "purple",
                        fontSize: "0.75rem", // text-xs
                        borderRadius: "9999px", // rounded-full
                        paddingX: 1.25, // px-2.5
                        paddingY: 0.5, // py-0.5
                      }}
                    />
                  </Box>
                </CardContent>
              </CardActionArea>
            </Card>
          </Grid>
          <Grid item xs={12} md={3}>
            <Card sx={{ padding: "0px" }}>
              <CardActionArea
                sx={{
                  display: "flex",
                  justifyContent: "center",
                  alignItems: "center",
                  flexDirection: "column",
                }}
                onClick={enableAdd}
              >
                <CardMedia
                  component="img"
                  sx={{
                    width: "88%",
                    height: "auto",
                    objectFit: "cover",
                    boxShadow: "0 4px 12px rgba(0, 0, 0, 0.2)",
                  }}
                  image="https://bit.ly/3Hlw1MQ"
                  alt="green iguana"
                />
                <CardContent sx={{ width: "88%", padding: "15px 0px 25px" }}>
                  <Typography gutterBottom variant="h5" component="div">
                    Realtime Quiz
                  </Typography>
                  <Typography variant="body2" sx={{ color: "gray", fontSize: "15px" }}>
                    Lizards are a widespread group of squamate reptiles, with over 6,000 species,
                    ranging across all continents except Antarctica
                  </Typography>
                  <Box sx={{ mt: 2, display: "flex", flexWrap: "wrap", gap: 1 }}>
                    <Chip
                      label="Collecting"
                      sx={{
                        backgroundColor: "rgba(128, 0, 128, 0.1)", // Màu nền tương tự bg-purple-100
                        color: "purple",
                        fontSize: "0.75rem", // text-xs
                        borderRadius: "9999px", // rounded-full
                        paddingX: 1.25, // px-2.5
                        paddingY: 0.5, // py-0.5
                      }}
                    />
                    <Chip
                      label="Untradable"
                      sx={{
                        backgroundColor: "rgba(128, 0, 128, 0.1)", // Màu nền tương tự bg-purple-100
                        color: "purple",
                        fontSize: "0.75rem", // text-xs
                        borderRadius: "9999px", // rounded-full
                        paddingX: 1.25, // px-2.5
                        paddingY: 0.5, // py-0.5
                      }}
                    />
                  </Box>
                </CardContent>
              </CardActionArea>
              <MDBox>
                <Modal
                  open={canAdd}
                  // onClose={unenableAdd}
                  aria-labelledby="modal-modal-title"
                  aria-describedby="modal-modal-description"
                >
                  <Box sx={style}>
                    {/* <MDBox display="flex" justifyContent="center" alignItems="center" pb={4} px={3}>
                      <MDBox>
                        <MDTypography
                          variant="h5"
                          sx={{
                            color: "#323232",
                            fontWeight: 900,
                            fontSize: 25,
                          }}
                        >
                          ADD NEW ACCOUNT
                        </MDTypography>
                      </MDBox>
                    </MDBox> */}
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
                            borderRadius: "2%",
                            border: "3px solid #fff",
                            boxShadow: "0 4px 12px rgba(0, 0, 0, 0.15)",
                            objectFit: "cover",
                          }}
                          image="https://bit.ly/3Hlw1MQ"
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
                            onChange={(event) => console.log(event.target.files)}
                            multiple
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
                        <MDInput fullWidth className={toggleStyle.input} />
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
                        <MDInput fullWidth multiline rows={3} className={toggleStyle.input} />
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
                          labelId="demo-simple-select-label"
                          id="demo-simple-select"
                          value="Mùa hè xanh"
                          sx={{ padding: "12px 2px", margin: "9px 0px 8px" }}
                          inputProps={{ "aria-label": "Without label" }}
                          className={toggleStyle.input}
                          fullWidth
                        >
                          <MenuItem value={"Mùa hè xanh"}>Quiz</MenuItem>
                          <MenuItem value={"Lúc lắc"}>Collection</MenuItem>
                        </Select>
                      </Grid>
                      <Grid
                        item
                        xs={12}
                        md={5}
                        display="flex"
                        justifyContent="flex-end"
                        alignItems="center"
                      >
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
                          <label className={toggleStyle.switch}>
                            <input type="checkbox" className={toggleStyle.checkbox} />
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
                      <MDButton variant="gradient" color="error" onClick={unenableAdd} mr={2}>
                        Cancel
                      </MDButton>
                      <MDButton
                        variant="gradient"
                        color="dark"
                        onClick={() => {
                          openSuccessSB();
                          unenableAdd();
                        }}
                      >
                        Apply
                      </MDButton>
                    </Stack>
                  </Box>
                </Modal>
              </MDBox>
            </Card>
          </Grid>
        </Grid>
      </MDBox>
      <Footer />
    </DashboardLayout>
  );
}

export default Games;
