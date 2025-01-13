import { useState, useEffect } from "react";
import {
  fetchGeneralEventsStat,
  fetchGeneralPlayersStat,
  fetchGeneralBrandsStat,
  fetchGeneralTotalEventsStat,
} from "../api";
import Grid from "@mui/material/Grid";
import ComplexStatisticsCard from "examples/Cards/StatisticsCards/ComplexStatisticsCard";
import MDBox from "components/MDBox";

function GeneralStatistic() {
  const [eventsStat, setEventsStat] = useState(null);
  const [playersStat, setPlayersStat] = useState(null);
  const [brandsStat, setBrandsStat] = useState(null);
  const [totalEventsStat, setTotalEventsStat] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      try {
        const [events, players, brands, totalEvents] = await Promise.all([
          fetchGeneralEventsStat(),
          fetchGeneralPlayersStat(),
          fetchGeneralBrandsStat(),
          fetchGeneralTotalEventsStat(),
        ]);
        setEventsStat(events);
        setPlayersStat(players);
        setBrandsStat(brands);
        setTotalEventsStat(totalEvents);
      } catch (error) {
        console.error("Error fetching data:", error);
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, []);

  return (
    <Grid container spacing={3}>
      {loading ? (
        <MDBox mx="auto" my={6}>
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
        <>
          <Grid item xs={12} md={6} lg={3}>
            <MDBox>
              <ComplexStatisticsCard
                color="error"
                icon="bookmark"
                title="Events This Month"
                count={eventsStat.total}
                percentage={{
                  color: eventsStat.percentage >= 0 ? "success" : "error",
                  amount: `${eventsStat.percentage >= 0 ? "+" : ""}${eventsStat.percentage}%`,
                  label: "than last month",
                }}
              />
            </MDBox>
          </Grid>
          <Grid item xs={12} md={6} lg={3}>
            <MDBox>
              <ComplexStatisticsCard
                color="info"
                icon="person"
                title="Players This Month"
                count={playersStat.total}
                percentage={{
                  color: playersStat.percentage >= 0 ? "success" : "error",
                  amount: `${playersStat.percentage >= 0 ? "+" : ""}${playersStat.percentage}%`,
                  label: "than last month",
                }}
              />
            </MDBox>
          </Grid>
          <Grid item xs={12} md={6} lg={3}>
            <MDBox>
              <ComplexStatisticsCard
                color="success"
                icon="handshake"
                title="Brands This Month"
                count={brandsStat.total}
                percentage={{
                  color: brandsStat.percentage >= 0 ? "success" : "error",
                  amount: `${brandsStat.percentage >= 0 ? "+" : ""}${brandsStat.percentage}%`,
                  label: "than last month",
                }}
              />
            </MDBox>
          </Grid>
          <Grid item xs={12} md={6} lg={3}>
            <MDBox>
              <ComplexStatisticsCard
                color="warning"
                icon="campaign"
                title="Total Events"
                count={totalEventsStat.total}
                percentage={{
                  color: "success",
                  amount: "",
                  label: `Updated latest`,
                }}
              />
            </MDBox>
          </Grid>
        </>
      )}
    </Grid>
  );
}

export default GeneralStatistic;
