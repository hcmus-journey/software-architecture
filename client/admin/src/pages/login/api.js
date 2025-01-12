import api from "api/index.js";

export const login = async (email, password) => {
  return api
    .post("/api/auth/login", { email, password })
    .then((response) => {
      localStorage.setItem("accessToken", response.data.accessToken);
      localStorage.setItem("refreshToken", response.data.refreshToken);
      return { success: true, msg: "" };
    })
    .catch((error) => {
      console.log(error);
      if (error.response && error.response.data) {
        return { success: false, msg: error.response.data.message };
      }
      return { success: false, msg: "Unexpected error when login!" };
    });
};
