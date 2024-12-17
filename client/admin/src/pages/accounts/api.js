const status = ["ACTIVE", "INACTIVE"];
const roles = ["ADMIN", "PLAYER", "COUNTERPART"];

let dbAccounts = [
  {
    id: crypto.randomUUID(),
    name: "Tran Anh Kiet",
    email: "kiet.tran@gmail.com",
    username: "kiet_tran",
    role: "ADMIN",
    status: "ACTIVE",
    phone: "0901234567",
  },
  {
    id: crypto.randomUUID(),
    name: "Nguyen Thi Lan",
    email: "lan.nguyen@gmail.com",
    username: "lan_nguyen",
    role: "PLAYER",
    status: "INACTIVE",
    phone: "0912345678",
  },
  {
    id: crypto.randomUUID(),
    name: "Le Quang Hieu",
    email: "hieu.le@hotmail.com",
    username: "hieu_le",
    role: "PLAYER",
    status: "ACTIVE",
    phone: "0923456789",
  },
  {
    id: crypto.randomUUID(),
    name: "Lazada Vietnam",
    email: "contact@lazada.vn",
    username: "lazada_vn",
    role: "COUNTERPART",
    status: "ACTIVE",
    phone: "0934567890",
  },
  {
    id: crypto.randomUUID(),
    name: "Pham Minh Tu",
    email: "tu.pham@yahoo.com",
    username: "minhtu",
    role: "PLAYER",
    status: "INACTIVE",
    phone: "0945678901",
  },
  {
    id: crypto.randomUUID(),
    name: "Nguyen Hoang Nam",
    email: "hoangnam.nguyen@gmail.com",
    username: "nam_nguyen",
    role: "PLAYER",
    status: "ACTIVE",
    phone: "0956789012",
  },
  {
    id: crypto.randomUUID(),
    name: "Trinh Thi Mai",
    email: "mai.trinh@gmail.com",
    username: "mai_trinh",
    role: "PLAYER",
    status: "ACTIVE",
    phone: "0967890123",
  },
];

export const fetchAllAccounts = () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        message: "get successfully!",
        total: 7,
        data: [...dbAccounts],
      });
    }, 2000);
  });
};

export const addNewAccount = (account) => {
  const id = crypto.randomUUID();
  delete account.password;
  account.id = id;
  dbAccounts.push(account);
  return {
    status: 200,
    message: "add successfully!",
    id,
  };
};

export const editAccount = (account) => {
  delete account.password;
  const updatedAccount = { ...account };

  const index = dbAccounts.findIndex((a) => a.id === account.id);

  if (index !== -1) {
    dbAccounts = [
      ...dbAccounts.slice(0, index),
      { ...dbAccounts[index], ...updatedAccount },
      ...dbAccounts.slice(index + 1),
    ];
    return {
      status: 200,
      message: "Edit successfully!",
    };
  }
  return {
    status: 404,
    message: "Account not found!",
  };
};

export const delAccount = (id) => {
  dbAccounts = dbAccounts.filter((a) => a.id != id);
  return {
    status: 200,
    message: "delete successfully!",
  };
};

export const loadAllStatus = () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        message: "get successfully!",
        total: 2,
        data: status,
      });
    }, 1000);
  });
};

export const loadAllRoles = () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        message: "get successfully!",
        total: 3,
        data: roles,
      });
    }, 1000);
  });
};
