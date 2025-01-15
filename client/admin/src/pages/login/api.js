import api from "api/index.js";

const toList = (msg) => {
  return Array.isArray(msg) ? [...msg] : [msg];
};

export const login = async (username, password) => {
  try {
    const response = await api.post("/api/auth/login", { username, password });
    if (response.status === 200) {
      localStorage.setItem("accessToken", response.data.accessToken);
      localStorage.setItem("refreshToken", response.data.refreshToken);
      return { success: true, message: toList("Login successful!") };
    }
  } catch (error) {
    if (error.response) {
      console.log("Status " + error.response.status + ": Fail to login!");
      return { success: false, message: toList(error.response.data.message) };
    } else {
      console.log("Cannot get response from server!", error.request);
    }
  }
  return { success: false, message: toList("Unexpected error when login!") };
};
