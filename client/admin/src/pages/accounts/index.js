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
import SwipeableDrawer from "@mui/material/SwipeableDrawer";
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
import MDSnackbar from "components/MDSnackbar";

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

function Accounts() {
  const [successSB, setSuccessSB] = useState(false);
  const [errorSB, setErrorSB] = useState(false);
  const openSuccessSB = () => setSuccessSB(true);
  const closeSuccessSB = () => setSuccessSB(false);
  const openErrorSB = () => setErrorSB(true);
  const closeErrorSB = () => setErrorSB(false);
  const [campaign, setCampaign] = useState("Mùa hè xanh");
  const handleSetCampaign = (event, newValue) => setCampaign(event.target.value);
  const [canFilter, setCanFilter] = useState(false);
  const { columns, rows } = authorsTableData();
  const renderSuccessSB = (
    <MDSnackbar
      color="success"
      icon="check"
      title="Material Dashboard"
      content="Hello, world! This is a notification message"
      dateTime="11 mins ago"
      open={successSB}
      onClose={closeSuccessSB}
      close={closeSuccessSB}
      bgWhite
    />
  );
  const renderErrorSB = (
    <MDSnackbar
      color="error"
      icon="warning"
      title="Material Dashboard"
      content="Hello, world! This is a notification message"
      dateTime="11 mins ago"
      open={errorSB}
      onClose={closeErrorSB}
      close={closeErrorSB}
      bgWhite
    />
  );

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
      <MDBox pt={2} pb={3}>
        <Grid container spacing={3}>
          <Grid item xs={12} md={12}>
            <Card sx={{ height: "100%" }}>
              <MDBox
                pt={2}
                px={2}
                display="flex"
                justifyContent="space-between"
                alignItems="center"
              >
                <MDBox>
                  <MDTypography variant="h6" fontWeight="medium">
                    Accounts
                  </MDTypography>
                  <MDBox display="flex" alignItems="center" lineHeight={0}>
                    <Icon
                      sx={{
                        fontWeight: "bold",
                        color: ({ palette: { info } }) => info.main,
                        mt: -0.5,
                      }}
                    >
                      done
                    </Icon>
                    <MDTypography variant="button" fontWeight="regular" color="text">
                      &nbsp;<strong>List of accounts</strong> in the system
                    </MDTypography>
                  </MDBox>
                </MDBox>
                <MDBox>
                  <Fragment>
                    <MDButton onClick={toggleDrawer(true)} variant="gradient" color="dark">
                      <Icon sx={{ fontWeight: "bold", mt: -0.05 }}>filter_alt</Icon>
                      &nbsp;Filters
                    </MDButton>
                    <SwipeableDrawer
                      anchor="right"
                      open={canFilter}
                      onClose={toggleDrawer(false)}
                      onOpen={toggleDrawer(true)}
                    >
                      <Box sx={{ width: 250 }} role="presentation">
                        <MDBox px={3} pt={4} pb={3.5}>
                          <MDTypography variant="h6">Search</MDTypography>
                          <MDBox mr={1} mt={1}>
                            <MDInput placeholder="Search here ..." fullWidth />
                          </MDBox>
                        </MDBox>
                        <MDBox px={3} pb={3.5}>
                          <MDTypography variant="h6">Status</MDTypography>
                          <FormGroup>
                            <FormControlLabel
                              control={<Checkbox defaultChecked />}
                              label="Active"
                            />
                            <FormControlLabel control={<Checkbox />} label="Inactive" />
                          </FormGroup>
                        </MDBox>
                        <MDBox px={3} pb={3.5}>
                          <MDTypography variant="h6">Type</MDTypography>
                          <FormGroup>
                            <FormControlLabel
                              control={<Checkbox defaultChecked />}
                              label="Player"
                            />
                            <FormControlLabel control={<Checkbox />} label="Admin" />
                            <FormControlLabel control={<Checkbox />} label="Counterpart" />
                          </FormGroup>
                        </MDBox>
                        <MDBox px={3} pb={5}>
                          <MDTypography variant="h6">Sort</MDTypography>
                          <FormControl fullWidth>
                            <Select
                              labelId="demo-simple-select-label"
                              id="demo-simple-select"
                              value={campaign}
                              onChange={handleSetCampaign}
                              sx={{ padding: "12px 2px", margin: "9px 0px 8px" }}
                              inputProps={{ "aria-label": "Without label" }}
                            >
                              <MenuItem value={"Mùa hè xanh"}>Mùa hè xanh</MenuItem>
                              <MenuItem value={"Lúc lắc"}>Lúc lắc</MenuItem>
                              <MenuItem value={"Truy tìm kho báu"}>Truy tìm kho báu</MenuItem>
                            </Select>
                          </FormControl>
                          <Tabs
                            orientation="horizontal"
                            value={accountTabValue}
                            onChange={handleSetAccountTabValue}
                          >
                            <Tab
                              label="ASC"
                              icon={
                                <Icon fontSize="small" sx={{ mt: -0.25 }}>
                                  arrow_upward
                                </Icon>
                              }
                            />
                            <Tab
                              label="DESC"
                              icon={
                                <Icon fontSize="small" sx={{ mt: -0.25 }}>
                                  arrow_downward
                                </Icon>
                              }
                            />
                          </Tabs>
                        </MDBox>
                        <Grid
                          container
                          spacing={0}
                          direction="row"
                          alignItems="center"
                          justifyContent="space-evenly"
                          pt={2}
                        >
                          <MDButton variant="gradient" color="error" onClick={toggleDrawer(false)}>
                            Cancel
                          </MDButton>
                          <MDButton variant="gradient" color="dark" onClick={toggleDrawer(false)}>
                            Apply
                          </MDButton>
                        </Grid>
                      </Box>
                    </SwipeableDrawer>
                  </Fragment>
                  &nbsp;&nbsp;
                  <MDButton variant="gradient" color="success" onClick={enableAdd}>
                    <Icon sx={{ fontWeight: "bold", mt: -0.05 }}>add</Icon>
                    &nbsp;Add New
                  </MDButton>
                </MDBox>
              </MDBox>
              <MDBox>
                <Modal
                  open={canAdd}
                  // onClose={unenableAdd}
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
                          ADD NEW ACCOUNT
                        </MDTypography>
                      </MDBox>
                    </MDBox>
                    <Grid container spacing={3}>
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
                          Fullname
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
                          Username
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
                          Password
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
                          Email
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
                          Phone
                        </Typography>
                        <MDInput className={toggleStyle.input} fullWidth />
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
                          Role
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
                          <MenuItem value={"Mùa hè xanh"}>Admin</MenuItem>
                          <MenuItem value={"Lúc lắc"}>Player</MenuItem>
                          <MenuItem value={"Truy tìm kho báu"}>Counterpart</MenuItem>
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
                          Active
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
              {renderSuccessSB}
              <MDBox p={2}>
                <Grid container spacing={3}>
                  <Grid item xs={12}>
                    <DataTable
                      table={{ columns, rows }}
                      isSorted={false}
                      entriesPerPage={false}
                      showTotalEntries={false}
                    />
                  </Grid>
                </Grid>
                <Grid
                  container
                  spacing={0}
                  direction="column"
                  alignItems="end"
                  justifyContent="center"
                >
                  <Grid item xs={12} sx={{ pt: 3, pb: 2 }}>
                    <MDPagination>
                      <MDPagination item>
                        <Icon>keyboard_arrow_left</Icon>
                      </MDPagination>
                      <MDPagination item active>
                        1
                      </MDPagination>
                      <MDPagination item>2</MDPagination>
                      <MDPagination item>3</MDPagination>
                      <MDPagination item>
                        <Icon>keyboard_arrow_right</Icon>
                      </MDPagination>
                    </MDPagination>
                  </Grid>
                </Grid>
              </MDBox>
            </Card>
          </Grid>
        </Grid>
      </MDBox>
      <Footer />
    </DashboardLayout>
  );
}

export default Accounts;
