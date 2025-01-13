import { createContext, useContext, useState, useMemo } from "react";
import PropTypes from "prop-types";

const ModalContext = createContext();
ModalContext.displayName = "ModalContext";

export function ModalProvider({ children }) {
  const [modal, setModal] = useState(false);
  const [isAdding, setIsAdding] = useState(false);
  const [cloneQuiz, setCloneQuiz] = useState({
    quizId: "",
    content: "",
    options: [
      { content: "", isCorrect: false },
      { content: "", isCorrect: false },
      { content: "", isCorrect: false },
      { content: "", isCorrect: false },
    ],
  });

  const toggleModal = (open) => setModal(open);
  const changeCloneQuiz = (quiz) => {
    if (quiz === null) {
      setCloneQuiz(null);
    } else {
      setCloneQuiz({ ...quiz });
    }
  };
  const toggleIsAdding = (flag) => setIsAdding(flag);

  const value = useMemo(
    () => ({ modal, toggleModal, cloneQuiz, changeCloneQuiz, isAdding, toggleIsAdding }),
    [modal, cloneQuiz, isAdding]
  );

  return <ModalContext.Provider value={value}>{children}</ModalContext.Provider>;
}

ModalProvider.propTypes = {
  children: PropTypes.node.isRequired,
};

export function useModalContext() {
  const context = useContext(ModalContext);

  if (!context) {
    throw new Error("useModalContext must be used within a ModalProvider.");
  }

  return context;
}
