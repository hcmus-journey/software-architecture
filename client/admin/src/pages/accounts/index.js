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
import { fetchAllAccounts } from "./api";
import { ModalProvider } from "./context";
import DashboardLayout from "examples/LayoutContainers/DashboardLayout";
import DashboardNavbar from "examples/Navbars/DashboardNavbar";
import Footer from "examples/Footer";
import Grid from "@mui/material/Grid";
import Card from "@mui/material/Card";
import Icon from "@mui/material/Icon";
import MDBox from "components/MDBox";
import MDTypography from "components/MDTypography";
import AccountsTable from "./components/AccountsTable";
import AccountsFilter from "./components/AccountsFilter";
import AccountFormModal from "./components/AccountFormModal";
import AddNewButton from "./components/AddNewButton";

function Accounts() {
  const [loading, setLoading] = useState(false);
  const [filters, setFilters] = useState({});
  const [accounts, setAccounts] = useState([]);

  const updateAccount = (account) => {
    setAccounts((prev) => {
      const updatedAccounts = [...prev];
      const index = updatedAccounts.findIndex((acc) => acc.id === account.id);
      if (index !== -1) {
        updatedAccounts[index] = { ...updatedAccounts[index], ...account };
      } else {
        updatedAccounts.push(account);
      }
      return updatedAccounts;
    });
  };
  const deleteAccount = (id) => {
    setAccounts((prev) => {
      return prev.filter((p) => p.id != id);
    });
  };
  const handleFiltersChange = (newFilters) => {
    setFilters(newFilters);
  };
  const fetchData = async () => {
    setLoading(true);
    try {
      const [response] = await Promise.all([fetchAllAccounts()]);
      setAccounts(response.data);
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
                      Accounts
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
                        &nbsp;<strong>List of accounts</strong> in the system
                      </MDTypography>
                    </MDBox>
                  </MDBox>
                  <MDBox>
                    <AccountsFilter changeFilters={handleFiltersChange} filters={filters} />
                    &nbsp;&nbsp;
                    <AddNewButton />
                  </MDBox>
                </MDBox>
                <MDBox>
                  <AccountFormModal updateAccount={updateAccount} />
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
                    <AccountsTable
                      accounts={accounts}
                      filters={filters}
                      deleteAccount={deleteAccount}
                    />
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

export default Accounts;
