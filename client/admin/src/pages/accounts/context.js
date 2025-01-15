import { createContext, useContext, useState, useMemo } from "react";
import PropTypes from "prop-types";

const ModalContext = createContext();
ModalContext.displayName = "ModalContext";

export function ModalProvider({ children }) {
  const [modal, setModal] = useState(false);
  const [cloneAccount, setCloneAccount] = useState({
    username: "",
    role: "PLAYER",
    status: "INACTIVE",
  });

  const toggleModal = (open) => setModal(open);
  const changeCloneAccount = (acc) => {
    setCloneAccount({ ...acc });
  };
  const handleChange = (key, value) => {
    setCloneAccount((prev) => ({ ...prev, [key]: value }));
  };

  const value = useMemo(
    () => ({ modal, toggleModal, cloneAccount, changeCloneAccount, handleChange }),
    [modal, cloneAccount]
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
