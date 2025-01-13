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
import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import DashboardLayout from "examples/LayoutContainers/DashboardLayout";
import DashboardNavbar from "examples/Navbars/DashboardNavbar";
import Footer from "examples/Footer";
import MDBox from "components/MDBox";
import Grid from "@mui/material/Grid";
import GeneralStatistic from "./components/GeneralStatistic";
import GameStatistic from "./components/GameStatistic";
import AccountsStatistic from "./components/AccountsStatistic";
import EventsStatistic from "./components/EventsStatistic";
import EventsOverview from "./components/EventsOverview";

function Dashboard() {
  const navigate = useNavigate();

  useEffect(() => {
    const token = localStorage.getItem("accessToken");
    if (!token) {
      navigate("/login");
    }
  }, []);

  return (
    <DashboardLayout>
      <DashboardNavbar />
      <MDBox py={3}>
        <GeneralStatistic />
        <Grid container spacing={3} mt={1}>
          <Grid item xs={12} md={5}>
            <GameStatistic />
          </Grid>
          <Grid item xs={12} md={7}>
            <AccountsStatistic />
          </Grid>
        </Grid>
        <Grid container spacing={3} mt={1}>
          <Grid item xs={12} md={8}>
            <EventsStatistic />
          </Grid>
          <Grid item xs={12} md={4}>
            <EventsOverview />
          </Grid>
        </Grid>
      </MDBox>
      <Footer />
    </DashboardLayout>
  );
}

export default Dashboard;
