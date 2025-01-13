import { useEffect, useState } from "react";
import { delQuiz } from "../api";
import { useModalContext } from "../context";
import { useNotification } from "context/NotificationContext";
import PropTypes from "prop-types";
import MDBox from "components/MDBox";
import MDTypography from "components/MDTypography";
import DataTable from "examples/Tables/DataTable";
import Tooltip from "@mui/material/Tooltip";

const columns = [
  { Header: "id", accessor: "id", width: "25%", align: "left" },
  { Header: "question", accessor: "question", width: "70%", align: "left" },
  { Header: "action", accessor: "action", align: "center" },
];

function QuizzesTable({ quizzes, deleteQuiz }) {
  const { toggleModal, changeCloneQuiz, toggleIsAdding } = useModalContext();
  const [_, dispatch] = useNotification();
  const [rows, setRows] = useState([]);

  const handleSuccess = (msg) => {
    dispatch({ type: "SHOW_SUCCESS", payload: msg });
  };
  const handleError = (msg) => {
    dispatch({ type: "SHOW_ERROR", payload: msg });
  };
  const handleEdit = (id) => {
    let quiz = quizzes.find((q) => q.quizId === id);
    if (quiz) {
      changeCloneQuiz(quiz);
      toggleIsAdding(false);
      toggleModal(true);
    }
  };
  const handleDelete = (id) => {
    const isSuccess = delQuiz(id);
    if (isSuccess) {
      deleteQuiz(id);
      handleSuccess("Delete the quiz successful!");
    } else {
      handleError("Fail to delete the quiz!");
    }
  };
  const getQuizRow = (quiz) => {
    return {
      id: (
        <MDBox sx={{ width: 250, whiteSpace: "nowrap" }}>
          <Tooltip title={quiz.quizId} arrow>
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
              {quiz.quizId}
            </MDTypography>
          </Tooltip>
        </MDBox>
      ),
      question: (
        <MDBox sx={{ width: 600, whiteSpace: "nowrap" }}>
          <Tooltip title={quiz.content} arrow>
            <MDTypography
              display="block"
              variant="caption"
              sx={{
                textOverflow: "ellipsis",
                overflow: "hidden",
                whiteSpace: "nowrap",
                maxWidth: "100%",
              }}
            >
              {quiz.content}
            </MDTypography>
          </Tooltip>
        </MDBox>
      ),
      action: (
        <MDBox sx={{ width: 130 }}>
          <MDBox display="flex" justifyContent="center" gap="5px">
            <button className="edit-button" onClick={() => handleEdit(quiz.quizId)}>
              <svg className="edit-svgIcon" viewBox="0 0 512 512">
                <path d="M410.3 231l11.3-11.3-33.9-33.9-62.1-62.1L291.7 89.8l-11.3 11.3-22.6 22.6L58.6 322.9c-10.4 10.4-18 23.3-22.2 37.4L1 480.7c-2.5 8.4-.2 17.5 6.1 23.7s15.3 8.5 23.7 6.1l120.3-35.4c14.1-4.2 27-11.8 37.4-22.2L387.7 253.7 410.3 231zM160 399.4l-9.1 22.7c-4 3.1-8.5 5.4-13.3 6.9L59.4 452l23-78.1c1.4-4.9 3.8-9.4 6.9-13.3l22.7-9.1v32c0 8.8 7.2 16 16 16h32zM362.7 18.7L348.3 33.2 325.7 55.8 314.3 67.1l33.9 33.9 62.1 62.1 33.9 33.9 11.3-11.3 22.6-22.6 14.5-14.5c25-25 25-65.5 0-90.5L453.3 18.7c-25-25-65.5-25-90.5 0zm-47.4 168l-144 144c-6.2 6.2-16.4 6.2-22.6 0s-6.2-16.4 0-22.6l144-144c6.2-6.2 16.4-6.2 22.6 0s6.2 16.4 0 22.6z"></path>
              </svg>
            </button>
            <button className="delete-button" onClick={() => handleDelete(quiz.quizId)}>
              <svg className="delete-svgIcon" viewBox="0 0 448 512">
                <path d="M135.2 17.7L128 32H32C14.3 32 0 46.3 0 64S14.3 96 32 96H416c17.7 0 32-14.3 32-32s-14.3-32-32-32H320l-7.2-14.3C307.4 6.8 296.3 0 284.2 0H163.8c-12.1 0-23.2 6.8-28.6 17.7zM416 128H32L53.2 467c1.6 25.3 22.6 45 47.9 45H346.9c25.3 0 46.3-19.7 47.9-45L416 128z"></path>
              </svg>
            </button>
          </MDBox>
        </MDBox>
      ),
    };
  };

  useEffect(() => {
    let newRows = [];
    let tempQuizzes = [...quizzes];

    tempQuizzes.map((quiz) => {
      newRows.push(getQuizRow(quiz));
    });
    setRows(newRows);
  }, [quizzes]);

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

QuizzesTable.propTypes = {
  quizzes: PropTypes.arrayOf(PropTypes.object).isRequired,
  deleteQuiz: PropTypes.func.isRequired,
};

export default QuizzesTable;
