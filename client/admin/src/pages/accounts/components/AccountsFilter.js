import PropTypes from "prop-types";
import { useEffect, useState, Fragment } from "react";
import { getAllStatus, getAllRoles } from "../api";
import { useMaterialUIController } from "context";
import Box from "@mui/material/Box";
import Icon from "@mui/material/Icon";
import SwipeableDrawer from "@mui/material/SwipeableDrawer";
import Checkbox from "@mui/material/Checkbox";
import MenuItem from "@mui/material/MenuItem";
import FormControlLabel from "@mui/material/FormControlLabel";
import FormGroup from "@mui/material/FormGroup";
import Tabs from "@mui/material/Tabs";
import Tab from "@mui/material/Tab";
import Select from "@mui/material/Select";
import Grid from "@mui/material/Grid";
import MDBox from "components/MDBox";
import MDButton from "components/MDButton";
import MDTypography from "components/MDTypography";
import MDInput from "components/MDInput";

function AccountFilterModal({ filters, changeFilters }) {
  const sortFields = ["userId", "username", "role", "status"];
  const [controller, dispatch] = useMaterialUIController();
  const { darkMode } = controller;
  const [status, setStatus] = useState([]);
  const [roles, setRoles] = useState([]);
  const [filterModal, setFilterModal] = useState(false);
  const [keyword, setKeyword] = useState("");
  const [statusFilter, setStatusFilter] = useState([]);
  const [roleFilter, setRoleFilter] = useState([]);
  const [sort, setSort] = useState({ field: sortFields[0], asc: true });
  const [sortTypeTab, setSortTypeTab] = useState("ASC");

  const handleSearchChange = (event) => {
    setKeyword(event.target.value);
  };
  const handleStatusChange = (event) => {
    const { value, checked } = event.target;
    setStatusFilter((prev) => (checked ? [...prev, value] : prev.filter((item) => item !== value)));
  };
  const handleRoleChange = (event) => {
    const { value, checked } = event.target;
    setRoleFilter((prev) => (checked ? [...prev, value] : prev.filter((item) => item !== value)));
  };
  const handleSortTypeChange = (event, newValue) => {
    setSortTypeTab(newValue);
    setSort((s) => ({
      ...s,
      asc: newValue === "ASC",
    }));
  };
  const handleSetSortField = (event) => {
    setSort((s) => ({
      field: event.target.value,
      asc: s.asc,
    }));
  };
  const resetFilters = () => {
    setKeyword(filters.keyword);
    setStatusFilter(filters.statusFilter);
    setRoleFilter(filters.roleFilter);
    setSort(filters.sort);
    setSortTypeTab(filters.sort.asc ? "ASC" : "DESC");
  };
  const applyFilters = () => {
    const newfilters = {
      keyword,
      statusFilter,
      roleFilter,
      sort,
    };
    changeFilters(newfilters);
    console.log("Applied filters:", newfilters);
  };
  const toggleDrawer = (open) => (event) => {
    if (event && event.type === "keydown" && (event.key === "Tab" || event.key === "Shift")) {
      return;
    }
    setFilterModal(open);
  };
  const loadData = () => {
    setStatus(getAllStatus());
    setRoles(getAllRoles());
    changeFilters({
      keyword: keyword,
      statusFilter: getAllStatus(),
      roleFilter: getAllRoles(),
      sort: sort,
    });
    setStatusFilter(getAllStatus());
    setRoleFilter(getAllRoles());
  };

  useEffect(() => {
    loadData();
  }, []);

  return (
    <Fragment>
      <MDButton
        onClick={() => {
          toggleDrawer(true)(event);
          resetFilters();
        }}
        variant="gradient"
        color={darkMode ? "light" : "dark"}
      >
        <Icon sx={{ fontWeight: "bold", mt: -0.05 }}>filter_alt</Icon>
        &nbsp;Filters
      </MDButton>
      <SwipeableDrawer
        anchor="right"
        open={filterModal}
        onClose={toggleDrawer(false)}
        onOpen={toggleDrawer(true)}
      >
        <Box
          sx={{ width: 250, height: "100%", display: "flex", flexDirection: "column" }}
          role="presentation"
        >
          <Box sx={{ flex: 1, overflowY: "auto" }}>
            <MDBox px={3} pt={4} pb={3.5}>
              <MDTypography variant="h6">Search</MDTypography>
              <MDBox mr={1} mt={1}>
                <MDInput
                  placeholder="Search here ..."
                  fullWidth
                  value={keyword}
                  onChange={handleSearchChange}
                />
              </MDBox>
            </MDBox>
            <MDBox px={3} pb={3}>
              <MDTypography variant="h6">Status</MDTypography>
              <FormGroup>
                {status.map((s) => (
                  <FormControlLabel
                    key={s}
                    control={
                      <Checkbox
                        value={s}
                        checked={statusFilter.includes(s)}
                        onChange={handleStatusChange}
                      />
                    }
                    label={s}
                  />
                ))}
              </FormGroup>
            </MDBox>
            <MDBox px={3} pb={3}>
              <MDTypography variant="h6">Role</MDTypography>
              <FormGroup>
                {roles.map((r) => (
                  <FormControlLabel
                    key={r}
                    control={
                      <Checkbox
                        value={r}
                        checked={roleFilter.includes(r)}
                        onChange={handleRoleChange}
                      />
                    }
                    label={r}
                  />
                ))}
              </FormGroup>
            </MDBox>
            <MDBox px={3} pb={4}>
              <MDTypography variant="h6">Sort</MDTypography>
              <Select
                labelId="sort-field-select-label"
                id="sort-field-select"
                value={sort.field}
                onChange={handleSetSortField}
                sx={{ padding: "12px 2px", margin: "3px 0px 6px" }}
                fullWidth
              >
                {sortFields.map((field) => (
                  <MenuItem key={field} value={field}>
                    {field.toUpperCase()}
                  </MenuItem>
                ))}
              </Select>
              <Tabs orientation="horizontal" value={sortTypeTab} onChange={handleSortTypeChange}>
                <Tab
                  label="ASC"
                  icon={
                    <Icon fontSize="small" sx={{ mt: -0.25 }}>
                      arrow_upward
                    </Icon>
                  }
                  value="ASC"
                />
                <Tab
                  label="DESC"
                  icon={
                    <Icon fontSize="small" sx={{ mt: -0.25 }}>
                      arrow_downward
                    </Icon>
                  }
                  value="DESC"
                />
              </Tabs>
            </MDBox>
          </Box>
          <Grid
            container
            spacing={0}
            direction="row"
            alignItems="center"
            justifyContent="space-evenly"
            sx={{ padding: 2 }}
          >
            <MDButton variant="gradient" color="error" onClick={resetFilters}>
              Reset
            </MDButton>
            <MDButton
              variant="gradient"
              color={darkMode ? "light" : "dark"}
              onClick={() => {
                toggleDrawer(false)(event);
                applyFilters();
              }}
            >
              Apply
            </MDButton>
          </Grid>
        </Box>
      </SwipeableDrawer>
    </Fragment>
  );
}
AccountFilterModal.propTypes = {
  filters: PropTypes.object.isRequired,
  changeFilters: PropTypes.func.isRequired,
};

export default AccountFilterModal;
