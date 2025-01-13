import { useState, useEffect, useMemo } from "react";
import { fetchAccountsStat } from "../api";
import Card from "@mui/material/Card";
import Icon from "@mui/material/Icon";
import Grid from "@mui/material/Grid";
import Tabs from "@mui/material/Tabs";
import Tab from "@mui/material/Tab";
import VerticalBarChart from "examples/Charts/BarCharts/VerticalBarChart";
import MDBox from "components/MDBox";
import MDTypography from "components/MDTypography";

function getLast12Months() {
  const monthNames = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "June",
    "July",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  const currentDate = new Date();
  const currentMonth = currentDate.getMonth() + 1;
  const currentYear = currentDate.getFullYear();
  const result = [];
  for (let i = 0; i < 12; i++) {
    const monthIndex = (currentMonth + i) % 12;
    const year = currentYear + (currentMonth - 12 + i >= 0 ? 0 : -1);
    result.push(`${monthNames[monthIndex]}/${year.toString().slice(-2)}`);
  }
  return result;
}

function AccountsStatistic() {
  const accountTypes = [
    { type: "Brand", icon: "business" },
    { type: "Player", icon: "person" },
  ];
  const [accountsStat, setAccountsStat] = useState([]);
  const [accountTypeTab, setAccountTypeTab] = useState(0);
  const [loading, setLoading] = useState(true);

  const handleSetAccountTypeTab = (event, newValue) => setAccountTypeTab(newValue);
  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      try {
        const [accounts] = await Promise.all([
          fetchAccountsStat(accountTypes[accountTypeTab].type),
        ]);
        setAccountsStat(accounts);
      } catch (error) {
        console.error("Error fetching data:", error);
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, [accountTypeTab]);

  const chartData = useMemo(
    () => ({
      labels: getLast12Months(),
      datasets: [
        {
          label: "Number of accounts",
          color: "primary",
          data: accountsStat,
        },
      ],
    }),
    [accountsStat]
  );

  return (
    <Card sx={{ height: "100%", minHeight: "440px" }}>
      <MDBox pt={2} px={2} display="flex" justifyContent="space-between" alignItems="center">
        <MDBox>
          <MDTypography variant="h6" fontWeight="medium">
            Accounts Statistic
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
              &nbsp;<strong>Number of accounts</strong> joining the system last 12 months
            </MDTypography>
          </MDBox>
        </MDBox>
        <Tabs orientation="horizontal" value={accountTypeTab} onChange={handleSetAccountTypeTab}>
          {accountTypes.map((item, index) => (
            <Tab
              key={index}
              label={item.type}
              sx={{ px: "10px" }}
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
              <VerticalBarChart chart={chartData} />
            </Grid>
          </Grid>
        </MDBox>
      )}
    </Card>
  );
}

export default AccountsStatistic;
