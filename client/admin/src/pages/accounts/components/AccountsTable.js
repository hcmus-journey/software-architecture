import { useEffect, useState } from "react";
import { useModalContext } from "../context";
import { useNotification } from "context/NotificationContext";
import PropTypes from "prop-types";
import MDBox from "components/MDBox";
import MDTypography from "components/MDTypography";
import MDBadge from "components/MDBadge";
import DataTable from "examples/Tables/DataTable";
import Tooltip from "@mui/material/Tooltip";

const columns = [
  { Header: "id", accessor: "id", width: "30%", align: "left" },
  { Header: "username", accessor: "username", width: "10%", align: "left" },
  { Header: "role", accessor: "role", width: "25%", align: "center" },
  { Header: "status", accessor: "status", width: "25%", align: "center" },
  { Header: "action", accessor: "action", align: "center" },
];
const getStatusColor = (status) => {
  if (status.toLowerCase() === "active") return "success";
  if (status.toLowerCase() === "inactive") return "warning";
  return "error";
};

function AccountsTable({ accounts, filters }) {
  const { toggleModal, changeCloneAccount } = useModalContext();
  const [_, dispatch] = useNotification();
  const [rows, setRows] = useState([]);

  const handleSuccess = (msg) => {
    dispatch({ type: "SHOW_SUCCESS", payload: msg });
  };
  const handleError = (msg) => {
    dispatch({ type: "SHOW_ERROR", payload: msg });
  };
  const handleEdit = (id) => {
    let acc = accounts.find((a) => a.id === id);
    if (acc) {
      changeCloneAccount(acc);
      toggleModal(true);
    }
  };
  const getAccountRow = (account) => {
    return {
      id: (
        <MDBox sx={{ width: 250, whiteSpace: "nowrap" }}>
          <Tooltip title={account.id} arrow>
            <MDTypography
              display="block"
              variant="caption"
              fontWeight="medium"
              sx={{
                textOverflow: "ellipsis",
                overflow: "hidden",
                whiteSpace: "nowrap",
                maxWidth: "100%",
              }}
            >
              {account.id}
            </MDTypography>
          </Tooltip>
        </MDBox>
      ),
      username: <MDTypography variant="caption">{account.username}</MDTypography>,
      role: (
        <MDTypography display="block" variant="caption" color="text" fontWeight="medium">
          {account.role}
        </MDTypography>
      ),
      status: (
        <MDBox ml={-1}>
          <MDBadge
            badgeContent={account.status}
            color={getStatusColor(account.status.toString())}
            variant="gradient"
            size="sm"
          />
        </MDBox>
      ),
      action: (
        <MDBox sx={{ width: 130 }}>
          <MDBox display="flex" justifyContent="center" gap="5px">
            <button className="edit-button" onClick={() => handleEdit(account.id)}>
              <svg className="edit-svgIcon" viewBox="0 0 512 512">
                <path d="M410.3 231l11.3-11.3-33.9-33.9-62.1-62.1L291.7 89.8l-11.3 11.3-22.6 22.6L58.6 322.9c-10.4 10.4-18 23.3-22.2 37.4L1 480.7c-2.5 8.4-.2 17.5 6.1 23.7s15.3 8.5 23.7 6.1l120.3-35.4c14.1-4.2 27-11.8 37.4-22.2L387.7 253.7 410.3 231zM160 399.4l-9.1 22.7c-4 3.1-8.5 5.4-13.3 6.9L59.4 452l23-78.1c1.4-4.9 3.8-9.4 6.9-13.3l22.7-9.1v32c0 8.8 7.2 16 16 16h32zM362.7 18.7L348.3 33.2 325.7 55.8 314.3 67.1l33.9 33.9 62.1 62.1 33.9 33.9 11.3-11.3 22.6-22.6 14.5-14.5c25-25 25-65.5 0-90.5L453.3 18.7c-25-25-65.5-25-90.5 0zm-47.4 168l-144 144c-6.2 6.2-16.4 6.2-22.6 0s-6.2-16.4 0-22.6l144-144c6.2-6.2 16.4-6.2 22.6 0s6.2 16.4 0 22.6z"></path>
              </svg>
            </button>
          </MDBox>
        </MDBox>
      ),
    };
  };

  useEffect(() => {
    let newRows = [];
    let tempAccounts = [...accounts];

    if (filters != null) {
      tempAccounts = tempAccounts.filter((a) =>
        filters.hasOwnProperty("keyword") && filters.keyword != null
          ? a.username.toLowerCase().includes(filters.keyword.toLowerCase())
          : true
      );
      tempAccounts = tempAccounts.filter((a) =>
        filters.hasOwnProperty("statusFilter") && filters.statusFilter != null
          ? filters.statusFilter.includes(a.status)
          : true
      );
      tempAccounts = tempAccounts.filter((a) =>
        filters.hasOwnProperty("roleFilter") && filters.roleFilter != null
          ? filters.roleFilter.includes(a.role)
          : true
      );
    }
    tempAccounts.sort((a, b) => {
      const field =
        filters && filters.hasOwnProperty("sort") && filters.sort != null
          ? filters.sort.field
          : "id";
      const asc =
        filters && filters.hasOwnProperty("sort") && filters.sort != null && !filters.sort.asc
          ? -1
          : 1;
      if (a[field] < b[field]) {
        return -1 * asc;
      }
      if (a[field] > b[field]) {
        return 1 * asc;
      }
      return 0;
    });
    tempAccounts.map((value) => {
      newRows.push(getAccountRow(value));
    });
    setRows(newRows);
  }, [accounts, filters]);

  return (
    <MDBox>
      <DataTable
        table={{ columns, rows }}
        isSorted={false}
        entriesPerPage={true}
        showTotalEntries={true}
        pagination={{
          variant: "gradient",
          color: "info",
        }}
      />
    </MDBox>
  );
}
AccountsTable.propTypes = {
  accounts: PropTypes.arrayOf(PropTypes.object).isRequired,
  filters: PropTypes.object.isRequired,
};

export default AccountsTable;
