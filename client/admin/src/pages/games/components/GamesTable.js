import { useEffect, useState } from "react";
import { fetchAllGames } from "../api";
import { useMaterialUIController } from "context";
import { useModalContext } from "../context";
import Grid from "@mui/material/Grid";
import Card from "@mui/material/Card";
import Box from "@mui/material/Box";
import Chip from "@mui/material/Chip";
import CardMedia from "@mui/material/CardMedia";
import CardActionArea from "@mui/material/CardActionArea";
import CardContent from "@mui/material/CardContent";
import Typography from "@mui/material/Typography";
import MDBox from "components/MDBox";
import GameFormModal from "./GameFormModal";

function AccountsTable() {
  const [controller, _] = useMaterialUIController();
  const { darkMode } = controller;
  const { toggleModal, changeCloneGame } = useModalContext();
  const [loading, setLoading] = useState(false);
  const [games, setGames] = useState([]);

  const updateGames = (game) => {
    setGames((prev) => {
      const updatedGames = [...prev];
      const index = updatedGames.findIndex((g) => g.id === game.id);
      if (index !== -1) {
        updatedGames[index] = { ...updatedGames[index], ...game };
      }
      return updatedGames;
    });
  };

  const fetchData = async () => {
    setLoading(true);
    try {
      const [response] = await Promise.all([fetchAllGames()]);
      setGames(response.data);
    } catch (error) {
      console.error("Error fetching data:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  return (
    <>
      <Grid container spacing={3} p={1}>
        {loading ? (
          <MDBox mx="auto" mt="200px">
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
          games.map((card) => (
            <Grid key={card.gameId} item xs={12} md={3}>
              <Card sx={{ padding: "0px" }}>
                <CardActionArea
                  sx={{
                    display: "flex",
                    justifyContent: "center",
                    alignItems: "center",
                    flexDirection: "column",
                  }}
                  onClick={() => {
                    changeCloneGame(card);
                    toggleModal(true);
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
                    image={card.imageUrl}
                    alt={card.name}
                  />
                  <CardContent sx={{ width: "88%", padding: "15px 0px 25px" }}>
                    <Typography gutterBottom variant="h5" component="div">
                      {card.name}
                    </Typography>
                    <Typography variant="body2" sx={{ color: "gray", fontSize: "15px" }}>
                      {card.description}
                    </Typography>
                    <Box sx={{ mt: 2, display: "flex", flexWrap: "wrap", gap: 1 }}>
                      <Chip
                        label={card.type}
                        sx={{
                          backgroundColor: darkMode
                            ? "rgba(228, 74, 228, 0.1)"
                            : "rgba(128, 0, 128, 0.1)",
                          color: darkMode ? "rgb(255, 70, 255)" : "purple",
                          fontSize: "0.75rem",
                          borderRadius: "9999px",
                          paddingX: 1.25,
                          paddingY: 0.5,
                        }}
                      />
                    </Box>
                  </CardContent>
                </CardActionArea>
              </Card>
            </Grid>
          ))
        )}
      </Grid>
      <GameFormModal updateGames={updateGames} />
    </>
  );
}

export default AccountsTable;
