import api from "api/index.js";

const status = ["BANNED", "ACTIVE", "INACTIVE"];
const roles = ["ADMIN", "PLAYER", "BRAND"];

export const fetchAllAccounts = async () => {
  try {
    const response = await api.get("/api/admin/users");
    if (response.status === 200) {
      return {
        message: "Get accounts successful!",
        total: response.data.length,
        data: response.data,
      };
    }
  } catch (error) {
    if (error.response) {
      console.log("Status " + error.response.status + ": Fail to get accounts!");
    } else {
      console.log("Cannot get response from server!", error.request);
    }
    return {
      message: "Fail to get accounts!",
      total: 0,
      data: [],
    };
  }
};

export const editAccount = async (account) => {
  try {
    const statusRes = await api.post(
      `/api/admin/users/${account.userId}/status?status=${account.status}`
    );
    const roleRes = await api.post(`/api/admin/users/${account.userId}/role?role=${account.role}`);
    if (statusRes.status === 200 && roleRes.status === 200) {
      return true;
    }
  } catch (error) {
    if (error.response) {
      console.log("Status " + error.response.status + ": Fail to update account!");
    } else {
      console.log("Cannot get response from server!", error.request);
    }
  }
  return false;
};

export const getAllStatus = () => {
  return status;
};

export const getAllRoles = () => {
  return roles;
};
