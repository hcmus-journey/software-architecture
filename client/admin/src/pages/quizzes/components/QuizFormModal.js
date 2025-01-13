import PropTypes from "prop-types";
import { useState, useEffect } from "react";
import { addNewQuiz, editQuiz } from "../api";
import { useNotification } from "context/NotificationContext";
import { useModalContext } from "../context";
import Modal from "@mui/material/Modal";
import Radio from "@mui/material/Radio";
import Box from "@mui/material/Box";
import Grid from "@mui/material/Grid";
import Typography from "@mui/material/Typography";
import Stack from "@mui/material/Stack";
import MDInput from "components/MDInput";
import MDBox from "components/MDBox";
import MDButton from "components/MDButton";
import MDTypography from "components/MDTypography";

const style = {
  position: "absolute",
  top: "50%",
  left: "50%",
  transform: "translate(-50%, -50%)",
  width: 600,
  bgcolor: "#d8d8d8",
  borderRadius: "5px",
  border: "2px solid #323232",
  boxShadow: "4px 4px #323232",
  p: 4,
};

function QuizFormModal({ updateQuiz }) {
  const { modal, toggleModal, cloneQuiz, isAdding } = useModalContext();
  const [_, dispatch] = useNotification();
  const [questionContent, setQuestionContent] = useState();
  const [selectedValue, setSelectedValue] = useState();
  const [question1, setQuestion1] = useState();
  const [question2, setQuestion2] = useState();
  const [question3, setQuestion3] = useState();
  const [question4, setQuestion4] = useState();

  const handleChangeRadio = (event) => {
    setSelectedValue(event.target.value);
  };
  const handleSuccess = (msg) => {
    dispatch({ type: "SHOW_SUCCESS", payload: msg });
  };
  const handleError = (msg) => {
    dispatch({ type: "SHOW_ERROR", payload: msg });
  };
  const resetFields = () => {
    setQuestionContent("");
    setSelectedValue("0");
    setQuestion1("");
    setQuestion2("");
    setQuestion3("");
    setQuestion4("");
  };
  const handleApply = async () => {
    const isMissingInfo =
      !questionContent || !question1 || !question2 || !question3 || !question4 || !selectedValue;
    if (isMissingInfo) {
      handleError("Please fill in all the quiz details!");
      return;
    }
    const successMessage = isAdding ? "Successfully added new quiz!" : "Successfully edited quiz!";
    const errorMessage = isAdding ? "Failed to add new quiz!" : "Failed to edit quiz!";
    let updatedQuiz = {
      quizId: cloneQuiz === null ? "" : cloneQuiz.quizId,
      content: questionContent,
      options: [
        {
          content: question1,
          isCorrect: selectedValue === "0",
        },
        {
          content: question2,
          isCorrect: selectedValue === "1",
        },
        {
          content: question3,
          isCorrect: selectedValue === "2",
        },
        {
          content: question4,
          isCorrect: selectedValue === "3",
        },
      ],
    };
    try {
      if (isAdding) {
        const id = await addNewQuiz(updatedQuiz);
        if (id != null) {
          updatedQuiz.quizId = id;
          updateQuiz(updatedQuiz);
          handleSuccess(successMessage);
        } else {
          handleError(errorMessage);
        }
      } else {
        const isSuccess = await editQuiz(updatedQuiz);
        if (isSuccess) {
          updateQuiz(updatedQuiz);
          handleSuccess(successMessage);
        } else {
          handleError(errorMessage);
        }
      }
      resetFields();
    } catch (error) {
      handleError("An error occurred while processing the quiz!");
    }
    toggleModal(false);
  };

  useEffect(() => {
    console.log(cloneQuiz);
    setSelectedValue(
      cloneQuiz === null
        ? "0"
        : cloneQuiz.options.findIndex((option) => option.isCorrect).toString()
    );
    setQuestion1(cloneQuiz === null ? "" : cloneQuiz.options[0].content);
    setQuestion2(cloneQuiz === null ? "" : cloneQuiz.options[1].content);
    setQuestion3(cloneQuiz === null ? "" : cloneQuiz.options[2].content);
    setQuestion4(cloneQuiz === null ? "" : cloneQuiz.options[3].content);
    setQuestionContent(cloneQuiz === null ? "" : cloneQuiz.content);
  }, [modal]);

  return (
    <Modal
      open={modal}
      aria-labelledby="modal-modal-title"
      aria-describedby="modal-modal-description"
    >
      <Box sx={style}>
        <MDBox display="flex" justifyContent="center" alignItems="center" pb={4} px={3}>
          <MDBox>
            <MDTypography
              variant="h5"
              sx={{
                color: "#323232",
                fontWeight: 900,
                fontSize: 25,
              }}
            >
              {!isAdding ? "Edit Quiz" : "Add New Quiz"}
            </MDTypography>
          </MDBox>
        </MDBox>
        <Grid container spacing={3}>
          <Grid item xs={12} display="flex" justifyContent="flex-start" alignItems="center">
            <Typography
              variant="h6"
              sx={{
                width: "110px",
                color: "#323232",
                fontWeight: 900,
              }}
            >
              Question
            </Typography>
            <MDInput
              placeholder="Enter the question here..."
              fullWidth
              className="input"
              type="text"
              value={questionContent}
              onChange={(e) => setQuestionContent(e.target.value)}
            />
          </Grid>
          <Grid item xs={12} md={12} display="flex" justifyContent="flex-start" alignItems="center">
            <Radio
              pl={1}
              checked={selectedValue === "0"}
              onChange={handleChangeRadio}
              value={"0"}
              name="radio-buttons"
              sx={{
                "&.Mui-checked": {
                  color: "#323232",
                },
                "& .MuiSvgIcon-root": {
                  border: "1.5px solid #323232",
                  borderRadius: "50%",
                },
              }}
            />
            <MDInput
              placeholder={`Enter answer 1...`}
              fullWidth
              className="input"
              type="text"
              value={question1}
              onChange={(e) => setQuestion1(e.target.value)}
            />
          </Grid>
          <Grid item xs={12} md={12} display="flex" justifyContent="flex-start" alignItems="center">
            <Radio
              pl={1}
              checked={selectedValue === "1"}
              onChange={handleChangeRadio}
              value={"1"}
              name="radio-buttons"
              sx={{
                "&.Mui-checked": {
                  color: "#323232",
                },
                "& .MuiSvgIcon-root": {
                  border: "1.5px solid #323232",
                  borderRadius: "50%",
                },
              }}
            />
            <MDInput
              placeholder={`Enter answer 2...`}
              fullWidth
              className="input"
              type="text"
              value={question2}
              onChange={(e) => setQuestion2(e.target.value)}
            />
          </Grid>
          <Grid item xs={12} md={12} display="flex" justifyContent="flex-start" alignItems="center">
            <Radio
              pl={1}
              checked={selectedValue === "2"}
              onChange={handleChangeRadio}
              value={"2"}
              name="radio-buttons"
              sx={{
                "&.Mui-checked": {
                  color: "#323232",
                },
                "& .MuiSvgIcon-root": {
                  border: "1.5px solid #323232",
                  borderRadius: "50%",
                },
              }}
            />
            <MDInput
              placeholder={`Enter answer 3...`}
              fullWidth
              className="input"
              type="text"
              value={question3}
              onChange={(e) => setQuestion3(e.target.value)}
            />
          </Grid>
          <Grid item xs={12} md={12} display="flex" justifyContent="flex-start" alignItems="center">
            <Radio
              pl={1}
              checked={selectedValue === "3"}
              onChange={handleChangeRadio}
              value={"3"}
              name="radio-buttons"
              sx={{
                "&.Mui-checked": {
                  color: "#323232",
                },
                "& .MuiSvgIcon-root": {
                  border: "1.5px solid #323232",
                  borderRadius: "50%",
                },
              }}
            />
            <MDInput
              placeholder={`Enter answer 4...`}
              fullWidth
              className="input"
              type="text"
              value={question4}
              onChange={(e) => setQuestion4(e.target.value)}
            />
          </Grid>
        </Grid>
        <Stack
          direction="row"
          spacing={1}
          sx={{
            justifyContent: "flex-end",
            alignItems: "center",
          }}
          mt={5}
        >
          <MDButton
            variant="gradient"
            color="error"
            onClick={() => {
              toggleModal(false);
              resetFields();
            }}
            mr={2}
          >
            Cancel
          </MDButton>
          <MDButton variant="gradient" color="dark" onClick={handleApply}>
            Apply
          </MDButton>
        </Stack>
      </Box>
    </Modal>
  );
}
QuizFormModal.propTypes = {
  updateQuiz: PropTypes.func.isRequired,
};

export default QuizFormModal;
