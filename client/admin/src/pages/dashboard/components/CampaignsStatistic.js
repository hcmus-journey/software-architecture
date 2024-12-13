import { useState, useEffect, useMemo } from "react";
import { fetchCampaignsStat } from "../api";
import { useMaterialUIController } from "context";
import Card from "@mui/material/Card";
import Icon from "@mui/material/Icon";
import Grid from "@mui/material/Grid";
import VerticalBarChart from "examples/Charts/BarCharts/VerticalBarChart";
import MDBox from "components/MDBox";
import MDTypography from "components/MDTypography";
import MDInput from "components/MDInput";
import MDButton from "components/MDButton";

function CampaignsStatistic() {
  const [controller, dispatch] = useMaterialUIController();
  const { darkMode } = controller;
  const [campaignsStat, setCampaignsStat] = useState({ dates: [], data: [] });
  const [loading, setLoading] = useState(true);
  const [startDate, setStartDate] = useState("2023-11-20");
  const [endDate, setEndDate] = useState("2024-11-24");

  const handleStartDateChange = (event) => {
    setStartDate(event.target.value);
  };
  const handleEndDateChange = (event) => {
    setEndDate(event.target.value);
  };
  const handleApply = async () => {
    setLoading(true);
    try {
      const [campaigns] = await Promise.all([fetchCampaignsStat(startDate, endDate)]);
      setCampaignsStat(campaigns);
    } catch (error) {
      console.error("Error fetching data:", error);
    } finally {
      setLoading(false);
    }
  };
  const chartData = useMemo(
    () => ({
      labels: campaignsStat.dates,
      datasets: [
        {
          label: "Number of campaigns",
          color: "primary",
          data: campaignsStat.data,
        },
      ],
    }),
    [campaignsStat]
  );
  useEffect(() => {
    handleApply();
  }, []);

  return (
    <Card sx={{ height: "100%", minHeight: "440px" }}>
      <MDBox pt={2} px={2} display="flex" justifyContent="space-between" alignItems="center">
        <MDBox>
          <MDTypography variant="h6" fontWeight="medium">
            Campaigns Statistic
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
              &nbsp;<strong>Number of campaigns</strong> created
            </MDTypography>
          </MDBox>
        </MDBox>
        <MDBox>
          <MDInput
            type="date"
            label="Start date"
            value={startDate}
            onChange={handleStartDateChange}
          />
          &nbsp;&nbsp;
          <MDInput type="date" label="End date" value={endDate} onChange={handleEndDateChange} />
          &nbsp;&nbsp;
          <MDButton variant="gradient" color={darkMode ? "light" : "dark"} onClick={handleApply}>
            Apply
          </MDButton>
        </MDBox>
      </MDBox>
      {loading ? (
        <MDBox mx="auto" my="auto">
          <div className="wrapper">
            <div className="circle"></div>
            <div className="circle"></div>
            <div className="circle"></div>
            <div className="shadow"></div>
            <div className="shadow"></div>
            <div className="shadow"></div>
          </div>
        </MDBox>
      ) : (
        <MDBox p={2}>
          <Grid container spacing={3}>
            <Grid item xs={12}>
              <VerticalBarChart chart={chartData} />
            </Grid>
          </Grid>
        </MDBox>
      )}
    </Card>
  );
}

export default CampaignsStatistic;
