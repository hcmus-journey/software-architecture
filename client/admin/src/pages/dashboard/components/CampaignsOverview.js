import { useState, useEffect, useMemo } from "react";
import { fetchLastestCampaigns } from "../api";
import Card from "@mui/material/Card";
import Icon from "@mui/material/Icon";
import MDBox from "components/MDBox";
import MDTypography from "components/MDTypography";
import TimelineItem from "examples/Timeline/TimelineItem";

function CampaignsOverview() {
  const colorPalette = ["success", "error", "info", "warning", "primary"];
  const [loading, setLoading] = useState(true);
  const [campaignsOverview, setCampaignsOverview] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      try {
        const [campaigns] = await Promise.all([fetchLastestCampaigns(5)]);
        setCampaignsOverview(campaigns);
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
            Campaigns Overview
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
              &nbsp;<strong>Latest 5 campaigns</strong> created
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
        <MDBox px={3} pt={2} pb={0}>
          {campaignsOverview.map((item, index) => (
            <TimelineItem
              key={index}
              color={colorPalette[index % 5]}
              icon="campaign"
              title={item.name + " - " + item.brand}
              dateTime={item.datetime}
            />
          ))}
        </MDBox>
      )}
    </Card>
  );
}

export default CampaignsOverview;
