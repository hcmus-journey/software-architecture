import { useState, useEffect, useMemo } from "react";
import { fetchAllCampaigns, fetchCampaignsDetailsStat } from "../api";
import { LineChart } from "@mui/x-charts/LineChart";
import { useMaterialUIController } from "context";
import { lineElementClasses, markElementClasses } from "@mui/x-charts/LineChart";
import Card from "@mui/material/Card";
import Icon from "@mui/material/Icon";
import Tabs from "@mui/material/Tabs";
import Tab from "@mui/material/Tab";
import Box from "@mui/material/Box";
import MenuItem from "@mui/material/MenuItem";
import Select from "@mui/material/Select";
import Grid from "@mui/material/Grid";
import FormControl from "@mui/material/FormControl";
import InputLabel from "@mui/material/InputLabel";
import MDBox from "components/MDBox";
import MDTypography from "components/MDTypography";
import MDButton from "components/MDButton";
import MDInput from "components/MDInput";

function CampaignsDetailsStatistic() {
  const darkColors = ["#90caf9", "#f48fb1", "#a5d6a7"];
  const lightColors = ["#1976d2", "#d32f2f", "#388e3c"];
  const [controller, dispatch] = useMaterialUIController();
  const { darkMode } = controller;
  const campaignTypes = [
    { type: "All Campaigns", icon: "bookmarks" },
    { type: "One Campaign", icon: "bookmark" },
  ];
  const [loading, setLoading] = useState(true);
  const [campaignTypeTab, setCampaignTypeTab] = useState(0);
  const [campaigns, setCampaigns] = useState([]);
  const [chosenCampaign, setChosenCampaign] = useState(null);
  const [campaignsDetails, setCampaignsDetails] = useState({ users: [], vouchers: [], dates: [] });
  const [startDate, setStartDate] = useState("2023-11-20");
  const [endDate, setEndDate] = useState("2024-11-24");

  const handleSetCampaignTypeTab = (event, newValue) => {
    setCampaignTypeTab(newValue);
  };
  const handleChosenCampaignChange = (event) => {
    setChosenCampaign(event.target.value);
  };
  const handleStartDateChange = (event) => {
    setStartDate(event.target.value);
  };
  const handleEndDateChange = (event) => {
    setEndDate(event.target.value);
  };
  const handleApply = async () => {
    setLoading(true);
    try {
      const [details] = await Promise.all([
        fetchCampaignsDetailsStat(
          campaignTypeTab === 0 ? null : chosenCampaign,
          startDate,
          endDate
        ),
      ]);
      setCampaignsDetails(details);
    } catch (error) {
      console.error("Error fetching data:", error);
    } finally {
      setLoading(false);
    }
  };
  const chartData = useMemo(
    () => ({
      series: [
        {
          data: campaignsDetails.users,
          label: "users",
          color: "#cc527a",
        },
        {
          data: campaignsDetails.vouchers,
          label: "vouchers",
          color: "#778aab",
        },
      ],
      xAxis: {
        scaleType: "point",
        data: campaignsDetails.dates,
      },
    }),
    [campaignsDetails]
  );
  useEffect(() => {
    const fetchAll = async () => {
      try {
        const [allCampaigns] = await Promise.all([fetchAllCampaigns()]);
        setCampaigns(allCampaigns);
        setChosenCampaign(allCampaigns?.length > 0 ? allCampaigns[0] : null);
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };
    const fetchData = async () => {
      campaigns.length > 0 ? "" : await fetchAll();
      handleApply();
    };
    fetchData();
  }, [chosenCampaign, campaignTypeTab]);

  return (
    <Card sx={{ height: "100%", minHeight: "595px" }}>
      <MDBox pt={2} px={2} display="flex" justifyContent="space-between" alignItems="center">
        <MDBox>
          <MDTypography variant="h6" fontWeight="medium">
            Campaigns Details Statistic
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
              &nbsp;<strong>Number of vouchers released and players playing </strong>
              in campaign(s)
            </MDTypography>
          </MDBox>
        </MDBox>
        <MDBox>
          {campaignTypeTab === 0 && (
            <>
              <MDInput
                type="date"
                label="Start date"
                value={startDate}
                onChange={handleStartDateChange}
              />
              &nbsp;&nbsp;
              <MDInput
                type="date"
                label="End date"
                value={endDate}
                onChange={handleEndDateChange}
              />
              &nbsp;&nbsp;
              <MDButton
                variant="gradient"
                color={darkMode ? "light" : "dark"}
                onClick={handleApply}
              >
                Apply
              </MDButton>
            </>
          )}
          {campaignTypeTab === 1 && (
            <Box sx={{ minWidth: 250 }}>
              <FormControl fullWidth>
                <InputLabel id="demo-simple-select-label">Chosen Campaign</InputLabel>
                <Select
                  labelId="demo-simple-select-label"
                  id="demo-simple-select"
                  value={chosenCampaign}
                  label="Chosen campaign"
                  onChange={handleChosenCampaignChange}
                  sx={{ padding: "12px 2px" }}
                >
                  {campaigns.map((item, index) => (
                    <MenuItem key={index} value={item}>
                      {item}
                    </MenuItem>
                  ))}
                </Select>
              </FormControl>
            </Box>
          )}
        </MDBox>
        <Tabs orientation="horizontal" value={campaignTypeTab} onChange={handleSetCampaignTypeTab}>
          {campaignTypes.map((item, index) => (
            <Tab
              key={index}
              label={item.type}
              icon={
                <Icon fontSize="small" sx={{ mt: -0.25 }}>
                  {item.icon}
                </Icon>
              }
            />
          ))}
        </Tabs>
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
              <LineChart
                height={500}
                series={chartData.series}
                grid={{
                  horizontal: true,
                  vertical: true,
                }}
                xAxis={[
                  {
                    ...chartData.xAxis,
                    stroke: darkMode ? "#ffffff" : "#000000",
                    tickLabelStyle: { fill: darkMode ? "#ffffff" : "#000000" },
                  },
                ]}
                yAxis={[
                  {
                    stroke: darkMode ? "#ffffff" : "#000000",
                    tickLabelStyle: { fill: darkMode ? "#ffffff" : "#000000" },
                  },
                ]}
                sx={{
                  [`& .${lineElementClasses.root}`]: {
                    strokeWidth: 2,
                  },
                  [`& .${markElementClasses.root}`]: {
                    scale: "0.6",
                    fill: "#fff",
                    strokeWidth: 2,
                  },
                }}
                slotProps={{
                  legend: {
                    labelStyle: {
                      fontSize: 18,
                      fill: darkMode ? "#ffffff" : "#000000",
                    },
                    direction: "row",
                    position: {
                      vertical: "top",
                      horizontal: "middle",
                    },
                    itemMarkWidth: 20,
                    itemMarkHeight: 6,
                    markGap: 5,
                    itemGap: 15,
                  },
                }}
              />
            </Grid>
          </Grid>
        </MDBox>
      )}
    </Card>
  );
}

export default CampaignsDetailsStatistic;
