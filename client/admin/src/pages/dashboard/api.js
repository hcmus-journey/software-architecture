export const fetchGeneralCampaignsStat = () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        total: 42,
        percentage: -15.0,
      });
    }, 1000);
  });
};

export const fetchGeneralPlayersStat = () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        total: 15,
        percentage: 0.2,
      });
    }, 2000);
  });
};

export const fetchGeneralCounterpartsStat = () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        total: 4,
        percentage: 0,
      });
    }, 1500);
  });
};

export const fetchGeneralIncomesStat = () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        total: 15050,
        lastUpdateDays: 2,
      });
    }, 2000);
  });
};

export const fetchGameStat = () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve([
        {
          title: "Quiz",
          count: 32,
        },
        {
          title: "Collection",
          count: 45,
        },
      ]);
    }, 800);
  });
};

export const fetchAccountsStat = (accountType) => {
  if (accountType === "Counterpart") {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve([1, 2, 1, 0, 3, 4, 0, 5, 10, 3, 5, 5]);
      }, 1500);
    });
  }
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve([15, 20, 12, 60, 20, 15, 30, 10, 20, 51, 60, 6]);
    }, 1000);
  });
};
export const fetchCampaignsStat = (startDate, endDate) => {
  if (startDate <= endDate) {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve({
          dates: [
            "2023-11-24",
            "2023-12-24",
            "2024-1-24",
            "2024-2-24",
            "2024-3-24",
            "2024-4-24",
            "2024-5-24",
            "2024-6-24",
            "2024-7-24",
            "2024-8-24",
            "2024-9-24",
            "2024-10-24",
            "2024-11-24",
          ],
          data: [3, 12, 11, 10, 13, 14, 10, 15, 10, 13, 15, 5, 3],
        });
      }, 1500);
    });
  }
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        dates: [],
        data: [],
      });
    }, 1000);
  });
};

export const fetchLastestCampaigns = (number) => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve([
        {
          name: "Mùa hè xanh",
          brand: "KFC Company",
          datetime: "22 DEC 7:20 PM",
        },
        {
          name: "Lắc lắc",
          brand: "Momo",
          datetime: "6 DEC 7:20 PM",
        },
        {
          name: "Q&A với MC AI",
          brand: "Shopee",
          datetime: "5 DEC 7:20 PM",
        },
        {
          name: "Kahoot",
          brand: "Longnest",
          datetime: "3 DEC 4:54 AM",
        },
        {
          name: "Truy tìm mảnh ghép",
          brand: "Lazada",
          datetime: "4 DEC 4:54 AM",
        },
      ]);
    }, 1500);
  });
};

export const fetchAllCampaigns = () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(["Mùa hè xanh", "Quiz Vui", "Lắc Xí Ngầu", "Đố vui", "Truy tìm kho báu"]);
    }, 500);
  });
};

export const fetchCampaignsDetailsStat = (campaign, startDate, endDate) => {
  if (campaign !== null) {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve({
          users: [30, 15, 13, 30, 53, 14, 40, 35, 50, 33, 25, 53, 30],
          vouchers: [30, 10, 11, 10, 13, 14, 10, 15, 10, 13, 15, 5, 3],
          dates: [
            "2023-11-24",
            "2023-12-24",
            "2024-1-24",
            "2024-2-24",
            "2024-3-24",
            "2024-4-24",
            "2024-5-24",
            "2024-6-24",
            "2024-7-24",
            "2024-8-24",
            "2024-9-24",
            "2024-10-24",
            "2024-11-24",
          ],
        });
      }, 1500);
    });
  }
  if (startDate <= endDate) {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve({
          users: [310, 115, 113, 310, 513, 114, 410, 315, 510, 313, 215, 513, 310],
          vouchers: [310, 110, 111, 110, 113, 114, 110, 115, 110, 113, 115, 51, 31],
          dates: [
            "2023-11-24",
            "2023-12-24",
            "2024-1-24",
            "2024-2-24",
            "2024-3-24",
            "2024-4-24",
            "2024-5-24",
            "2024-6-24",
            "2024-7-24",
            "2024-8-24",
            "2024-9-24",
            "2024-10-24",
            "2024-11-24",
          ],
        });
      }, 1500);
    });
  }
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        users: [],
        vouchers: [],
        dates: [],
      });
    }, 1000);
  });
};
