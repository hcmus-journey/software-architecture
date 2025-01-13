import api from "api/index.js";

export const fetchGeneralEventsStat = async () => {
  try {
    const response = await api.get("/api/events");
    if (response.status === 200) {
      const events = response.data;
      const now = new Date();
      const currentMonth = now.getMonth() + 1;
      const currentYear = now.getFullYear();
      const lastMonth = currentMonth === 1 ? 12 : currentMonth - 1;
      const lastMonthYear = currentMonth === 1 ? currentYear - 1 : currentYear;

      const currentMonthEvents = events.filter((event) => {
        const eventDate = new Date(event.createdAt);
        return eventDate.getMonth() + 1 === currentMonth && eventDate.getFullYear() === currentYear;
      });

      const lastMonthEvents = events.filter((event) => {
        const eventDate = new Date(event.createdAt);
        return eventDate.getMonth() + 1 === lastMonth && eventDate.getFullYear() === lastMonthYear;
      });

      const totalCurrentMonth = currentMonthEvents.length;
      const totalLastMonth = lastMonthEvents.length;

      const percentageChange =
        totalLastMonth === 0
          ? totalCurrentMonth > 0
            ? 100
            : 0
          : ((totalCurrentMonth - totalLastMonth) / totalLastMonth) * 100;

      return {
        total: totalCurrentMonth,
        percentage: parseFloat(percentageChange.toFixed(1)),
      };
    } else {
      return { total: 0, percentage: 0 };
    }
  } catch (error) {
    console.error("Error fetching events:", error.message);
    return { total: 0, percentage: 0 };
  }
};

export const fetchGeneralPlayersStat = async () => {
  try {
    const response = await api.get("/api/admin/users");
    if (response.status === 200) {
      const users = response.data;
      const now = new Date();
      const currentMonth = now.getMonth() + 1;
      const currentYear = now.getFullYear();
      const lastMonth = currentMonth === 1 ? 12 : currentMonth - 1;
      const lastMonthYear = currentMonth === 1 ? currentYear - 1 : currentYear;

      const currentMonthPlayers = users.filter((user) => {
        const userDate = new Date(user.createdAt);
        return (
          user.role === "PLAYER" &&
          userDate.getMonth() + 1 === currentMonth &&
          userDate.getFullYear() === currentYear
        );
      });

      const lastMonthPlayers = users.filter((user) => {
        const userDate = new Date(user.createdAt);
        return (
          user.role === "PLAYER" &&
          userDate.getMonth() + 1 === lastMonth &&
          userDate.getFullYear() === lastMonthYear
        );
      });

      const totalCurrentMonth = currentMonthPlayers.length;
      const totalLastMonth = lastMonthPlayers.length;

      const percentageChange =
        totalLastMonth === 0
          ? totalCurrentMonth > 0
            ? 100
            : 0
          : ((totalCurrentMonth - totalLastMonth) / totalLastMonth) * 100;

      return {
        total: totalCurrentMonth,
        percentage: parseFloat(percentageChange.toFixed(1)),
      };
    } else {
      return { total: 0, percentage: 0 };
    }
  } catch (error) {
    console.error("Error fetching players:", error.message);
    return { total: 0, percentage: 0 };
  }
};

export const fetchGeneralBrandsStat = async () => {
  try {
    const response = await api.get("/api/admin/users");
    if (response.status === 200) {
      const users = response.data;
      const now = new Date();
      const currentMonth = now.getMonth() + 1;
      const currentYear = now.getFullYear();
      const lastMonth = currentMonth === 1 ? 12 : currentMonth - 1;
      const lastMonthYear = currentMonth === 1 ? currentYear - 1 : currentYear;

      const currentMonthBrands = users.filter((user) => {
        const userDate = new Date(user.createdAt);
        return (
          user.role === "BRAND" &&
          userDate.getMonth() + 1 === currentMonth &&
          userDate.getFullYear() === currentYear
        );
      });

      const lastMonthBrands = users.filter((user) => {
        const userDate = new Date(user.createdAt);
        return (
          user.role === "BRAND" &&
          userDate.getMonth() + 1 === lastMonth &&
          userDate.getFullYear() === lastMonthYear
        );
      });

      const totalCurrentMonth = currentMonthBrands.length;
      const totalLastMonth = lastMonthBrands.length;

      const percentageChange =
        totalLastMonth === 0
          ? totalCurrentMonth > 0
            ? 100
            : 0
          : ((totalCurrentMonth - totalLastMonth) / totalLastMonth) * 100;

      return {
        total: totalCurrentMonth,
        percentage: parseFloat(percentageChange.toFixed(1)),
      };
    } else {
      return { total: 0, percentage: 0 };
    }
  } catch (error) {
    console.error("Error fetching brands:", error.message);
    return { total: 0, percentage: 0 };
  }
};

export const fetchGeneralTotalEventsStat = async () => {
  try {
    const response = await api.get("/api/events");
    if (response.status === 200) {
      const events = response.data;
      const totalEvents = events.length;
      return { total: totalEvents };
    } else {
      return { total: 0 };
    }
  } catch (error) {
    console.error("Error fetching events:", error.message);
    return { total: 0 };
  }
};

export const fetchGameStat = async () => {
  try {
    const response = await api.get("/api/events");
    if (response.status === 200) {
      const events = response.data;

      const gameCount = {};

      events.forEach((event) => {
        if (event.games && Array.isArray(event.games)) {
          event.games.forEach((game) => {
            const gameType = game.type;
            gameCount[gameType] = (gameCount[gameType] || 0) + 1;
          });
        }
      });

      const gameStat = Object.keys(gameCount).map((key) => ({
        title: key,
        count: gameCount[key],
      }));

      return gameStat;
    } else {
      return [];
    }
  } catch (error) {
    console.error("Error fetching game stats:", error.message);
    return [];
  }
};

export const fetchAccountsStat = async (accountType) => {
  try {
    const response = await api.get("/api/admin/users");

    if (response.status === 200) {
      const users = response.data;

      const currentDate = new Date();
      const currentMonth = currentDate.getMonth();
      const currentYear = currentDate.getFullYear();

      const stats = Array(12).fill(0);

      users.forEach((user) => {
        if (user.role === accountType.toUpperCase()) {
          const createdDate = new Date(user.createdAt);
          const year = createdDate.getFullYear();
          const month = createdDate.getMonth();

          if (
            (year === currentYear && month <= currentMonth) ||
            (year === currentYear - 1 && month > currentMonth)
          ) {
            const index = year === currentYear ? currentMonth - month : 12 - (month - currentMonth);
            stats[index]++;
          }
        }
      });

      return stats;
    } else {
      return [];
    }
  } catch (error) {
    console.error("Error fetching accounts stats:", error.message);
    return [];
  }
};

export const fetchEventsStat = async (startDate, endDate) => {
  if (new Date(startDate) > new Date(endDate)) {
    return {
      dates: [],
      data: [],
    };
  }
  try {
    const response = await api.get("/api/events");
    if (response.status === 200) {
      const events = response.data;

      const start = new Date(startDate);
      const end = new Date(endDate);

      const filteredEvents = events.filter((event) => {
        const eventDate = new Date(event.createdAt);
        return eventDate >= start && eventDate <= end;
      });

      const dates = [];
      let current = new Date(start);
      current.setDate(1);
      while (current <= end) {
        dates.push(current.toISOString().slice(0, 7));
        current.setMonth(current.getMonth() + 1);
      }

      const data = dates.map((date) => {
        const [year, month] = date.split("-");
        return filteredEvents.filter((event) => {
          const eventDate = new Date(event.createdAt);
          return (
            eventDate.getFullYear() === parseInt(year, 10) &&
            eventDate.getMonth() + 1 === parseInt(month, 10)
          );
        }).length;
      });

      return {
        dates,
        data,
      };
    }
  } catch (error) {
    console.error("Error fetching events stat:", error.message);
  }

  return {
    dates: [],
    data: [],
  };
};

export const fetchLastestEvents = async (number) => {
  try {
    const response = await api.get("/api/events");

    if (response.status === 200) {
      const events = response.data;

      const sortedEvents = events.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));

      const latestEvents = sortedEvents.slice(0, number);

      const formattedEvents = latestEvents.map((event) => ({
        name: event.name,
        brand: event.totalVouchers + "total vouchers",
        datetime: new Date(event.createdAt).toLocaleString("en-US", {
          weekday: "short",
          day: "numeric",
          month: "short",
          year: "numeric",
          hour: "numeric",
          minute: "numeric",
        }),
      }));

      return formattedEvents;
    }
  } catch (error) {
    console.error("Error fetching latest events:", error.message);
  }
  return [];
};

// export const fetchAllEvents = async () => {
//   return new Promise((resolve) => {
//     setTimeout(() => {
//       resolve(["Mùa hè xanh", "Quiz Vui", "Lắc Xí Ngầu", "Đố vui", "Truy tìm kho báu"]);
//     }, 500);
//   });
// };

// export const fetchEventsDetailsStat = async (event, startDate, endDate) => {
//   if (event !== null) {
//     return new Promise((resolve) => {
//       setTimeout(() => {
//         resolve({
//           users: [30, 15, 13, 30, 53, 14, 40, 35, 50, 33, 25, 53, 30],
//           vouchers: [30, 10, 11, 10, 13, 14, 10, 15, 10, 13, 15, 5, 3],
//           dates: [
//             "2023-11-24",
//             "2023-12-24",
//             "2024-1-24",
//             "2024-2-24",
//             "2024-3-24",
//             "2024-4-24",
//             "2024-5-24",
//             "2024-6-24",
//             "2024-7-24",
//             "2024-8-24",
//             "2024-9-24",
//             "2024-10-24",
//             "2024-11-24",
//           ],
//         });
//       }, 1500);
//     });
//   }
//   if (startDate <= endDate) {
//     return new Promise((resolve) => {
//       setTimeout(() => {
//         resolve({
//           users: [310, 115, 113, 310, 513, 114, 410, 315, 510, 313, 215, 513, 310],
//           vouchers: [310, 110, 111, 110, 113, 114, 110, 115, 110, 113, 115, 51, 31],
//           dates: [
//             "2023-11-24",
//             "2023-12-24",
//             "2024-1-24",
//             "2024-2-24",
//             "2024-3-24",
//             "2024-4-24",
//             "2024-5-24",
//             "2024-6-24",
//             "2024-7-24",
//             "2024-8-24",
//             "2024-9-24",
//             "2024-10-24",
//             "2024-11-24",
//           ],
//         });
//       }, 1500);
//     });
//   }
//   return new Promise((resolve) => {
//     setTimeout(() => {
//       resolve({
//         users: [],
//         vouchers: [],
//         dates: [],
//       });
//     }, 1000);
//   });
// };
