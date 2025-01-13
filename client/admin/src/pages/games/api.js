import api from "api/index.js";

// let dbGames = [
//   {
//     gameId: crypto.randomUUID(),
//     imageUrl:
//       "https://img.freepik.com/premium-vector/gaming-remote-controller-victor-illustration-mascot-logo-design_1146923-176.jpg",
//     name: "Truy Tìm Kho Báu",
//     description:
//       "Bạn sẽ vào vai một nhà thám hiểm đang khám phá một hòn đảo bí ẩn. Nhiệm vụ của bạn là tìm kiếm các cổ vật, giải mã những bí ẩn và tránh những cạm bẫy trên đảo để tìm ra kho báu bị chôn vùi từ lâu.",
//     type: "SHAKE_PHONE",
//   },
//   {
//     gameId: crypto.randomUUID(),
//     imageUrl:
//       "https://media.wired.com/photos/62855b1bb6cfd378a30c474a/master/pass/Build-Game-Watch-It-Die-Hyper-Scape-Games.jpg",
//     name: "Tấn Công Không Gian",
//     description:
//       "Bạn là chỉ huy của một phi đội chiến đấu không gian, nhiệm vụ là bảo vệ hành tinh của bạn khỏi các cuộc tấn công của kẻ thù ngoài hành tinh. Sử dụng tàu chiến của bạn để tiêu diệt kẻ thù và hoàn thành các nhiệm vụ trong từng cấp độ.",
//     type: "QUIZ",
//   },
// ];

export const fetchAllGames = async () => {
  try {
    const response = await api.get("/api/games");
    if (response.status === 200) {
      return {
        message: "Get games successful!",
        total: response.data.length,
        data: response.data,
      };
    }
  } catch (error) {
    if (error.response) {
      console.log("Status " + error.response.status + ": Fail to get games!");
    } else {
      console.log("Cannot get response from server!", error.request);
    }
  }
  return {
    message: "Fail to get games!",
    total: 0,
    data: [],
  };
};

export const editGame = async (game) => {
  try {
    const response = await api.put(`/api/games/${game.gameId}`, {
      name: game.name,
      description: game.description,
    });
    if (response.status === 200) {
      return true;
    }
  } catch (error) {
    if (error.response) {
      console.log("Status " + error.response.status + ": Fail to update game!");
    } else {
      console.log("Cannot get response from server!", error.request);
    }
  }
  return false;
};
