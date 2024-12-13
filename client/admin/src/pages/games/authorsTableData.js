/* eslint-disable react/prop-types */
/* eslint-disable react/function-component-definition */
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

// Material Dashboard 2 React components
import { useState } from "react";
import MDBox from "components/MDBox";
import MDTypography from "components/MDTypography";
import MDBadge from "components/MDBadge";
import Menu from "@mui/material/Menu";
import Icon from "@mui/material/Icon";
import MenuItem from "@mui/material/MenuItem";

export default function data() {
  const [menu, setMenu] = useState(null);
  const openMenu = ({ currentTarget }) => setMenu(currentTarget);
  const closeMenu = () => setMenu(null);
  const renderMenu = (
    <Menu
      id="simple-menu"
      anchorEl={menu}
      anchorOrigin={{
        vertical: "top",
        horizontal: "left",
      }}
      transformOrigin={{
        vertical: "top",
        horizontal: "right",
      }}
      open={Boolean(menu)}
      onClose={closeMenu}
    >
      <MenuItem onClick={closeMenu}>
        <Icon fontSize="small" color="success">
          mode_edit
        </Icon>
        <MDTypography variant="button" fontWeight="bold" color="success">
          &nbsp;Edit
        </MDTypography>
      </MenuItem>
      <MenuItem onClick={closeMenu}>
        <Icon fontSize="small" color="error">
          delete
        </Icon>
        <MDTypography variant="button" fontWeight="bold" color="error">
          &nbsp;Delete
        </MDTypography>
      </MenuItem>
    </Menu>
  );

  const User = ({ fullname, email }) => (
    <MDBox display="flex" alignItems="center" lineHeight={1}>
      <MDBox lineHeight={1}>
        <MDTypography display="block" variant="button" fontWeight="medium">
          {fullname}
        </MDTypography>
        <MDTypography variant="caption">{email}</MDTypography>
      </MDBox>
    </MDBox>
  );

  return {
    columns: [
      { Header: "info", accessor: "user", width: "25%", align: "left" },
      { Header: "username", accessor: "username", align: "left" },
      { Header: "type", accessor: "type", align: "center" },
      { Header: "status", accessor: "status", align: "center" },
      { Header: "phone", accessor: "phone", align: "center" },
      { Header: "action", accessor: "action", align: "center" },
    ],

    rows: [
      {
        user: <User fullname="John Michael" email="john@creative-tim.com" />,
        username: <MDTypography variant="caption">admin123</MDTypography>,
        type: (
          <MDTypography display="block" variant="caption" color="text" fontWeight="medium">
            Admin
          </MDTypography>
        ),
        status: (
          <MDBox ml={-1}>
            <MDBadge badgeContent="Active" color="success" variant="gradient" size="sm" />
          </MDBox>
        ),
        phone: (
          <MDTypography component="a" href="#" variant="caption" color="text" fontWeight="medium">
            0908088888
          </MDTypography>
        ),
        action: (
          <>
            <MDBox color="text" px={2}>
              <Icon
                sx={{ cursor: "pointer", fontWeight: "bold" }}
                fontSize="small"
                onClick={openMenu}
              >
                more_vert
              </Icon>
            </MDBox>
            {renderMenu}
          </>
        ),
      },
      {
        user: <User fullname="John Michael" email="john@creative-tim.com" />,
        username: <MDTypography variant="caption">admin123</MDTypography>,
        type: (
          <MDTypography display="block" variant="caption" color="text" fontWeight="medium">
            Player
          </MDTypography>
        ),
        status: (
          <MDBox ml={-1}>
            <MDBadge badgeContent="Active" color="success" variant="gradient" size="sm" />
          </MDBox>
        ),
        phone: (
          <MDTypography component="a" href="#" variant="caption" color="text" fontWeight="medium">
            0908088888
          </MDTypography>
        ),
        action: (
          <>
            <MDBox color="text" px={2}>
              <Icon
                sx={{ cursor: "pointer", fontWeight: "bold" }}
                fontSize="small"
                onClick={openMenu}
              >
                more_vert
              </Icon>
            </MDBox>
            {renderMenu}
          </>
        ),
      },
      {
        user: <User fullname="John Michael" email="john@creative-tim.com" />,
        username: <MDTypography variant="caption">admin123</MDTypography>,
        type: (
          <MDTypography display="block" variant="caption" color="text" fontWeight="medium">
            Counterpart
          </MDTypography>
        ),
        status: (
          <MDBox ml={-1}>
            <MDBadge badgeContent="Inactive" color="error" variant="gradient" size="sm" />
          </MDBox>
        ),
        phone: (
          <MDTypography component="a" href="#" variant="caption" color="text" fontWeight="medium">
            0908088888
          </MDTypography>
        ),
        action: (
          <>
            <MDBox color="text" px={2}>
              <Icon
                sx={{ cursor: "pointer", fontWeight: "bold" }}
                fontSize="small"
                onClick={openMenu}
              >
                more_vert
              </Icon>
            </MDBox>
            {renderMenu}
          </>
        ),
      },
      {
        user: <User fullname="John Michael" email="john@creative-tim.com" />,
        username: <MDTypography variant="caption">admin123</MDTypography>,
        type: (
          <MDTypography display="block" variant="caption" color="text" fontWeight="medium">
            Admin
          </MDTypography>
        ),
        status: (
          <MDBox ml={-1}>
            <MDBadge badgeContent="Active" color="success" variant="gradient" size="sm" />
          </MDBox>
        ),
        phone: (
          <MDTypography component="a" href="#" variant="caption" color="text" fontWeight="medium">
            0908088888
          </MDTypography>
        ),
        action: (
          <>
            <MDBox color="text" px={2}>
              <Icon
                sx={{ cursor: "pointer", fontWeight: "bold" }}
                fontSize="small"
                onClick={openMenu}
              >
                more_vert
              </Icon>
            </MDBox>
            {renderMenu}
          </>
        ),
      },
      {
        user: <User fullname="John Michael" email="john@creative-tim.com" />,
        username: <MDTypography variant="caption">admin123</MDTypography>,
        type: (
          <MDTypography display="block" variant="caption" color="text" fontWeight="medium">
            Admin
          </MDTypography>
        ),
        status: (
          <MDBox ml={-1}>
            <MDBadge badgeContent="Active" color="success" variant="gradient" size="sm" />
          </MDBox>
        ),
        phone: (
          <MDTypography component="a" href="#" variant="caption" color="text" fontWeight="medium">
            0908088888
          </MDTypography>
        ),
        action: (
          <>
            <MDBox color="text" px={2}>
              <Icon
                sx={{ cursor: "pointer", fontWeight: "bold" }}
                fontSize="small"
                onClick={openMenu}
              >
                more_vert
              </Icon>
            </MDBox>
            {renderMenu}
          </>
        ),
      },
      {
        user: <User fullname="John Michael" email="john@creative-tim.com" />,
        username: <MDTypography variant="caption">admin123</MDTypography>,
        type: (
          <MDTypography display="block" variant="caption" color="text" fontWeight="medium">
            Admin
          </MDTypography>
        ),
        status: (
          <MDBox ml={-1}>
            <MDBadge badgeContent="Active" color="success" variant="gradient" size="sm" />
          </MDBox>
        ),
        phone: (
          <MDTypography component="a" href="#" variant="caption" color="text" fontWeight="medium">
            0908088888
          </MDTypography>
        ),
        action: (
          <>
            <MDBox color="text" px={2}>
              <Icon
                sx={{ cursor: "pointer", fontWeight: "bold" }}
                fontSize="small"
                onClick={openMenu}
              >
                more_vert
              </Icon>
            </MDBox>
            {renderMenu}
          </>
        ),
      },
    ],
  };
}
