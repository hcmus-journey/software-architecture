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
import { useState, useEffect } from "react";
import { fetchAllQuizzes } from "./api";
import { ModalProvider } from "./context";
import DashboardLayout from "examples/LayoutContainers/DashboardLayout";
import DashboardNavbar from "examples/Navbars/DashboardNavbar";
import Footer from "examples/Footer";
import Grid from "@mui/material/Grid";
import Card from "@mui/material/Card";
import Icon from "@mui/material/Icon";
import MDBox from "components/MDBox";
import MDTypography from "components/MDTypography";
import QuizzesTable from "./components/QuizzesTable";
import QuizFormModal from "./components/QuizFormModal";
import AddNewButton from "./components/AddNewButton";

function Quizzes() {
  const [loading, setLoading] = useState(false);
  const [quizzes, setQuizzes] = useState([]);

  const updateQuiz = (quiz) => {
    setQuizzes((prev) => {
      const updatedQuizzes = [...prev];
      const index = updatedQuizzes.findIndex((q) => q.quizId === quiz.quizId);
      if (index !== -1) {
        updatedQuizzes[index] = { ...updatedQuizzes[index], ...quiz };
      } else {
        updatedQuizzes.push(quiz);
      }
      return updatedQuizzes;
    });
  };
  const deleteQuiz = (id) => {
    setQuizzes((prev) => {
      return prev.filter((q) => q.quizId != id);
    });
  };
  const fetchData = async () => {
    setLoading(true);
    try {
      const [response] = await Promise.all([fetchAllQuizzes()]);
      setQuizzes(response.data);
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
    <DashboardLayout>
      <DashboardNavbar />
      <ModalProvider>
        <MDBox pt={2} pb={3} sx={{ minHeight: "90vh" }}>
          <Grid container spacing={3}>
            <Grid item xs={12} md={12}>
              <Card sx={{ height: "100%", minHeight: "250px" }}>
                <MDBox
                  pt={2}
                  px={2}
                  display="flex"
                  justifyContent="space-between"
                  alignItems="center"
                >
                  <MDBox>
                    <MDTypography variant="h6" fontWeight="medium">
                      Quizzes
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
                        &nbsp;<strong>List of quizzes</strong> in the system
                      </MDTypography>
                    </MDBox>
                  </MDBox>
                  <MDBox>
                    <AddNewButton />
                  </MDBox>
                </MDBox>
                <MDBox>
                  <QuizFormModal updateQuiz={updateQuiz} />
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
                    <QuizzesTable quizzes={quizzes} deleteQuiz={deleteQuiz} />
                  </MDBox>
                )}
              </Card>
            </Grid>
          </Grid>
        </MDBox>
      </ModalProvider>
      <Footer />
    </DashboardLayout>
  );
}

export default Quizzes;
