import { useState, useEffect } from "react";
import { fetchGameStat, fetchGamePlayStat } from "../api";
import { PieChart, pieArcLabelClasses } from "@mui/x-charts/PieChart";
import Card from "@mui/material/Card";
import Icon from "@mui/material/Icon";
import MDBox from "components/MDBox";
import MDTypography from "components/MDTypography";
import Grid from "@mui/material/Grid";

function GamePlayStatistic() {
  const colorPalette = ["#0066CC", "#CA6C0F", "#FF4560"];
  const [gameStat, setGameStat] = useState({
    total: 0,
    data: [],
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      try {
        const [game] = await Promise.all([fetchGamePlayStat()]);
        console.log(game);
        const gameData = [
          {
            title: "Shake Game",
            count: game.shakeGameAttempts,
          },
          {
            title: "Quiz Game",
            count: game.quizGameAttempts,
          },
        ];
        const total = gameData.reduce((sum, item) => sum + item.count, 0);
        setGameStat({ total, data: gameData });
      } catch (error) {
        console.error("Error fetching data:", error);
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, []);

  return (
    <Card sx={{ height: "100%" }}>
      <MDBox pt={2} px={2} display="flex" justifyContent="space-between" alignItems="center">
        <MDBox>
          <MDTypography variant="h6" fontWeight="medium">
            Game Attempt Statistic
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
              &nbsp;<strong>Total player attempts</strong> of each game
            </MDTypography>
          </MDBox>
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
              <PieChart
                series={[
                  {
                    arcLabelMinAngle: 35,
                    arcLabelRadius: "75%",
                    arcLabel: (item) => `${Math.round((item.value / gameStat.total) * 100)}%`,
                    faded: { color: "white" },
                    data: gameStat.data.map((item, index) => ({
                      label: item.title,
                      value: item.count,
                      color: colorPalette[index % colorPalette.length],
                    })),
                    highlightScope: { fade: "global", highlight: "item" },
                    faded: { color: "gray" },
                    valueFormatter: (item) => `${item.value} plays`,
                  },
                ]}
                sx={{
                  [`& .${pieArcLabelClasses.root}`]: {
                    fill: "white",
                    fontSize: 16,
                  },
                }}
                slotProps={{
                  legend: {
                    labelStyle: {
                      fontSize: 18,
                      fill: "gray",
                    },
                    itemMarkWidth: 18,
                    itemMarkHeight: 6,
                    markGap: 5,
                  },
                }}
                height={300}
              />
            </Grid>
          </Grid>
        </MDBox>
      )}
    </Card>
  );
}

export default GamePlayStatistic;
