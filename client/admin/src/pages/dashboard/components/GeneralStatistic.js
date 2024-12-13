import { useState, useEffect } from "react";
import {
  fetchGeneralCampaignsStat,
  fetchGeneralPlayersStat,
  fetchGeneralCounterpartsStat,
  fetchGeneralIncomesStat,
} from "../api";
import Grid from "@mui/material/Grid";
import ComplexStatisticsCard from "examples/Cards/StatisticsCards/ComplexStatisticsCard";
import MDBox from "components/MDBox";

function GeneralStatistic() {
  const [campaignsStat, setCampaignsStat] = useState(null);
  const [playersStat, setPlayersStat] = useState(null);
  const [counterpartsStat, setCounterpartsStat] = useState(null);
  const [incomesStat, setIncomesStat] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      try {
        const [campaigns, players, counterparts, incomes] = await Promise.all([
          fetchGeneralCampaignsStat(),
          fetchGeneralPlayersStat(),
          fetchGeneralCounterpartsStat(),
          fetchGeneralIncomesStat(),
        ]);
        setCampaignsStat(campaigns);
        setPlayersStat(players);
        setCounterpartsStat(counterparts);
        setIncomesStat(incomes);
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
                title="Campaigns This Month"
                count={campaignsStat.total}
                percentage={{
                  color: campaignsStat.percentage >= 0 ? "success" : "error",
                  amount: `${campaignsStat.percentage >= 0 ? "+" : ""}${campaignsStat.percentage}%`,
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
                title="Players Playing Today"
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
                title="Counterparts This Month"
                count={counterpartsStat.total}
                percentage={{
                  color: counterpartsStat.percentage >= 0 ? "success" : "error",
                  amount: `${counterpartsStat.percentage >= 0 ? "+" : ""}${
                    counterpartsStat.percentage
                  }%`,
                  label: "than last month",
                }}
              />
            </MDBox>
          </Grid>
          <Grid item xs={12} md={6} lg={3}>
            <MDBox>
              <ComplexStatisticsCard
                color="warning"
                icon="attach_money"
                title="Incomes"
                count={incomesStat.total + "$"}
                percentage={{
                  color: "success",
                  amount: "",
                  label: `Updated ${incomesStat.lastUpdateDays} days ago`,
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
