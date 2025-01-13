import { createContext, useContext, useState, useMemo } from "react";
import PropTypes from "prop-types";

const ModalContext = createContext();
ModalContext.displayName = "ModalContext";

export function ModalProvider({ children }) {
  const [modal, setModal] = useState(false);
  const [cloneGame, setCloneGame] = useState({
    gameId: "",
    name: "",
    description: "",
    imageUrl: "",
    type: "",
  });

  const toggleModal = (open) => setModal(open);
  const changeCloneGame = (g) => {
    if (g === null) {
      setCloneGame({
        gameId: "",
        name: "",
        description: "",
        imageUrl: "",
        type: "",
      });
    } else {
      setCloneGame({ ...g });
    }
  };
  const handleChange = (key, value) => {
    setCloneGame((prev) => ({ ...prev, [key]: value }));
  };

  const value = useMemo(
    () => ({ modal, toggleModal, cloneGame, changeCloneGame, handleChange }),
    [modal, cloneGame]
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
