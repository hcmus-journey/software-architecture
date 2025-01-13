import api from "api/index.js";

export const fetchAllQuizzes = async () => {
  try {
    const response = await api.get("/api/quiz-games/quizzes");
    if (response.status === 200) {
      return {
        message: "Get quizzes successful!",
        total: length(response.data),
        data: response.data,
      };
    }
  } catch (error) {
    if (error.response) {
      console.log("Status " + error.response.status + ": Fail to get quizzes!");
    } else {
      console.log("Cannot get response from server!", error.request);
    }
  }
  return {
    message: "Fail to get quizzes!",
    total: 0,
    data: [],
  };
};

export const addNewQuiz = async (quiz) => {
  try {
    const response = await api.post(`/api/quiz-games/quizzes`, quiz);
    if (response.status === 200) {
      return response.data.id;
    }
  } catch (error) {
    if (error.response) {
      console.log("Status " + error.response.status + ": Fail to add new quiz!");
    } else {
      console.log("Cannot get response from server!", error.request);
    }
  }
  return "";
};

export const editQuiz = async (quiz) => {
  try {
    const response = await api.put(`/api/quiz-games/quizzes/${quiz.quizId}`, quiz);
    if (response.status === 200) {
      return true;
    }
  } catch (error) {
    if (error.response) {
      console.log("Status " + error.response.status + ": Fail to update quiz!");
    } else {
      console.log("Cannot get response from server!", error.request);
    }
  }
  return false;
};

export const delQuiz = async (id) => {
  try {
    const response = await api.delete(`/api/quiz-games/quizzes/${id}`);
    if (response.status === 200) {
      return true;
    }
  } catch (error) {
    if (error.response) {
      console.log("Status " + error.response.status + ": Fail to delete quiz!");
    } else {
      console.log("Cannot get response from server!", error.request);
    }
  }
  return false;
};
