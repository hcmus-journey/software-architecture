const gameTypes = ["QUIZ", "COLLECTION"];

let dbGames = [
  {
    id: crypto.randomUUID(),
    image:
      "https://img.freepik.com/premium-vector/gaming-remote-controller-victor-illustration-mascot-logo-design_1146923-176.jpg",
    title: "Truy Tìm Kho Báu",
    guide:
      "Bạn sẽ vào vai một nhà thám hiểm đang khám phá một hòn đảo bí ẩn. Nhiệm vụ của bạn là tìm kiếm các cổ vật, giải mã những bí ẩn và tránh những cạm bẫy trên đảo để tìm ra kho báu bị chôn vùi từ lâu.",
    type: gameTypes[1],
    tradable: true,
  },
  {
    id: crypto.randomUUID(),
    image:
      "https://media.wired.com/photos/62855b1bb6cfd378a30c474a/master/pass/Build-Game-Watch-It-Die-Hyper-Scape-Games.jpg",
    title: "Tấn Công Không Gian",
    guide:
      "Bạn là chỉ huy của một phi đội chiến đấu không gian, nhiệm vụ là bảo vệ hành tinh của bạn khỏi các cuộc tấn công của kẻ thù ngoài hành tinh. Sử dụng tàu chiến của bạn để tiêu diệt kẻ thù và hoàn thành các nhiệm vụ trong từng cấp độ.",
    type: gameTypes[0],
    tradable: false,
  },
];

export const fetchAllGames = () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        message: "get successfully!",
        total: 2,
        data: [...dbGames],
      });
    }, 2000);
  });
};
export const editGame = (game) => {
  const updatedGame = { ...game };
  const index = dbGames.findIndex((g) => g.id === game.id);
  if (index !== -1) {
    dbGames = [
      ...dbGames.slice(0, index),
      { ...dbGames[index], ...updatedGame },
      ...dbGames.slice(index + 1),
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
export const loadAllTypes = () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        message: "get successfully!",
        total: 2,
        data: gameTypes,
      });
    }, 1000);
  });
};
