let dbQuizzes = [
  {
    quizId: "00852e65-6a72-423f-b856-313fd6c6c73a",
    content: "Thủ đô của Việt Nam là gì?",
    options: [
      {
        content: "TP. Hồ Chí Minh",
        isCorrect: false,
      },
      {
        content: "Hà Nội",
        isCorrect: true,
      },
      {
        content: "Đà Nẵng",
        isCorrect: false,
      },
      {
        content: "Huế",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "fddd5bbb-3f31-4168-85d4-2e4d8808aff8",
    content: "Ai là người lãnh đạo cuộc khởi nghĩa Lam Sơn?",
    options: [
      {
        content: "Lê Lợi",
        isCorrect: true,
      },
      {
        content: "Nguyễn Huệ",
        isCorrect: false,
      },
      {
        content: "Trần Hưng Đạo",
        isCorrect: false,
      },
      {
        content: "Phan Bội Châu",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "c4c2bebf-f3f8-405a-9daa-f080cad52af5",
    content: "Số pi (π) xấp xỉ bằng bao nhiêu?",
    options: [
      {
        content: "3.14",
        isCorrect: true,
      },
      {
        content: "2.71",
        isCorrect: false,
      },
      {
        content: "1.62",
        isCorrect: false,
      },
      {
        content: "3.16",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "cbf2f2ba-c1e5-44b4-b948-971334463e2d",
    content: "Phương trình hóa học của phản ứng tạo nước là gì?",
    options: [
      {
        content: "H2 + O2 -> H2O",
        isCorrect: false,
      },
      {
        content: "H2 + O -> H2O",
        isCorrect: false,
      },
      {
        content: "2H + O2 -> H2O",
        isCorrect: false,
      },
      {
        content: "2H2 + O2 -> 2H2O",
        isCorrect: true,
      },
    ],
  },
  {
    quizId: "bcc56891-95ab-4e6e-bcc2-e1466b1294e9",
    content: 'Ai là tác giả của tác phẩm "Truyện Kiều"?',
    options: [
      {
        content: "Hồ Xuân Hương",
        isCorrect: false,
      },
      {
        content: "Nguyễn Trãi",
        isCorrect: false,
      },
      {
        content: "Tố Hữu",
        isCorrect: false,
      },
      {
        content: "Nguyễn Du",
        isCorrect: true,
      },
    ],
  },
  {
    quizId: "01263d70-b3b4-4312-bef7-6d020356bf87",
    content: "Năm nào diễn ra chiến thắng Điện Biên Phủ?",
    options: [
      {
        content: "1945",
        isCorrect: false,
      },
      {
        content: "1975",
        isCorrect: false,
      },
      {
        content: "1954",
        isCorrect: true,
      },
      {
        content: "1968",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "15d1fd16-93f8-418e-b6d0-77cc0c46a7e7",
    content: "Trong vật lý, đại lượng nào có đơn vị đo là Newton?",
    options: [
      {
        content: "Công suất",
        isCorrect: false,
      },
      {
        content: "Lực",
        isCorrect: true,
      },
      {
        content: "Khối lượng",
        isCorrect: false,
      },
      {
        content: "Nhiệt độ",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "a4e6a6af-9c80-45ce-baa0-ce442337ea7c",
    content: "Nguyên tố hóa học nào có ký hiệu là O?",
    options: [
      {
        content: "Oxi",
        isCorrect: true,
      },
      {
        content: "Vàng",
        isCorrect: false,
      },
      {
        content: "Sắt",
        isCorrect: false,
      },
      {
        content: "Nitơ",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "79699e8d-e24a-440a-8790-793b0927a1dd",
    content: "Quốc gia nào lớn nhất thế giới về diện tích?",
    options: [
      {
        content: "Nga",
        isCorrect: true,
      },
      {
        content: "Trung Quốc",
        isCorrect: false,
      },
      {
        content: "Hoa Kỳ",
        isCorrect: false,
      },
      {
        content: "Canada",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "6c6725f8-3533-44fd-bacf-125a8e24f5df",
    content: "Tam giác có 2 cạnh bằng nhau được gọi là gì?",
    options: [
      {
        content: "Tam giác vuông",
        isCorrect: false,
      },
      {
        content: "Tam giác đều",
        isCorrect: false,
      },
      {
        content: "Tam giác cân",
        isCorrect: true,
      },
      {
        content: "Tam giác thường",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "aee9de2b-d74f-47b2-a684-ed2b17c9ebf7",
    content: "Ai là người sáng lập ra Cộng hòa Xã hội Chủ nghĩa Việt Nam?",
    options: [
      {
        content: "Hồ Chí Minh",
        isCorrect: true,
      },
      {
        content: "Lê Duẩn",
        isCorrect: false,
      },
      {
        content: "Phạm Văn Đồng",
        isCorrect: false,
      },
      {
        content: "Nguyễn Văn Linh",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "757bb10f-4d88-4c49-b937-bf1e35e96aa0",
    content: "Tổng thống đầu tiên của Hoa Kỳ là ai?",
    options: [
      {
        content: "Abraham Lincoln",
        isCorrect: false,
      },
      {
        content: "George Washington",
        isCorrect: true,
      },
      {
        content: "Thomas Jefferson",
        isCorrect: false,
      },
      {
        content: "Franklin D. Roosevelt",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "828d7e36-abac-45c6-8870-9e0c286829da",
    content: "Quốc gia nào có hình dáng giống chiếc ủng?",
    options: [
      {
        content: "Ý",
        isCorrect: true,
      },
      {
        content: "Pháp",
        isCorrect: false,
      },
      {
        content: "Tây Ban Nha",
        isCorrect: false,
      },
      {
        content: "Hy Lạp",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "99d3bcac-4c3b-4fe3-a83d-ee4a75e36ce5",
    content: "Chim cánh cụt sống ở đâu?",
    options: [
      {
        content: "Châu Phi",
        isCorrect: false,
      },
      {
        content: "Nam Cực",
        isCorrect: true,
      },
      {
        content: "Châu Á",
        isCorrect: false,
      },
      {
        content: "Châu Úc",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "a347e371-7622-4908-baf1-1d9da56f4a32",
    content: "Bức tranh 'Mona Lisa' được vẽ bởi ai?",
    options: [
      {
        content: "Pablo Picasso",
        isCorrect: false,
      },
      {
        content: "Vincent van Gogh",
        isCorrect: false,
      },
      {
        content: "Leonardo da Vinci",
        isCorrect: true,
      },
      {
        content: "Claude Monet",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "7cf01ea6-92e2-4190-9abb-78f3cf7fca74",
    content: "Điều nào là yếu tố cần thiết cho sự sống trên trái đất?",
    options: [
      {
        content: "Ánh sáng",
        isCorrect: false,
      },
      {
        content: "Nước",
        isCorrect: true,
      },
      {
        content: "Nhiệt độ",
        isCorrect: false,
      },
      {
        content: "Không khí",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "fe5dd561-83cd-4bf0-814a-087e69bcfce3",
    content: "Quốc gia nào có nền văn hóa nổi bật với Kimono?",
    options: [
      {
        content: "Trung Quốc",
        isCorrect: false,
      },
      {
        content: "Nhật Bản",
        isCorrect: true,
      },
      {
        content: "Hàn Quốc",
        isCorrect: false,
      },
      {
        content: "Thái Lan",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "764ff446-910b-4f03-99f1-ebc3510a7384",
    content: "Lý thuyết tiến hóa của loài người được đưa ra bởi ai?",
    options: [
      {
        content: "Isaac Newton",
        isCorrect: false,
      },
      {
        content: "Charles Darwin",
        isCorrect: true,
      },
      {
        content: "Galileo Galilei",
        isCorrect: false,
      },
      {
        content: "Albert Einstein",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "a0b1d8cf-1eb1-40a2-944a-d105415ad714",
    content: "Câu chuyện 'Romeo và Juliet' được viết bởi tác giả nào?",
    options: [
      {
        content: "Charles Dickens",
        isCorrect: false,
      },
      {
        content: "William Shakespeare",
        isCorrect: true,
      },
      {
        content: "Jane Austen",
        isCorrect: false,
      },
      {
        content: "Mark Twain",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "a97ee9ca-c8d5-4f52-80c3-4cd56abc9fea",
    content: "Sông dài nhất thế giới là gì?",
    options: [
      {
        content: "Amazon",
        isCorrect: true,
      },
      {
        content: "Nile",
        isCorrect: false,
      },
      {
        content: "Yangtze",
        isCorrect: false,
      },
      {
        content: "Mississippi",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "8a2c4529-e26a-4ece-9cac-75a1d9f77876",
    content: "Nước nào là quốc gia đông dân nhất thế giới?",
    options: [
      {
        content: "Ấn Độ",
        isCorrect: false,
      },
      {
        content: "Trung Quốc",
        isCorrect: true,
      },
      {
        content: "Hoa Kỳ",
        isCorrect: false,
      },
      {
        content: "Indonesia",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "88e87f48-8d70-430e-8487-adfa6e0fb4fe",
    content: "Công trình vĩ đại nào được xây dựng ở Ai Cập cổ đại?",
    options: [
      {
        content: "Đền Taj Mahal",
        isCorrect: false,
      },
      {
        content: "Vạn Lý Trường Thành",
        isCorrect: false,
      },
      {
        content: "Kim Tự Tháp Giza",
        isCorrect: true,
      },
      {
        content: "Tháp Eiffel",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "64d58ebd-777c-4c09-9506-6b69847d97ff",
    content: "Tác phẩm 'Văn học là vũ khí mạnh nhất để thay đổi thế giới' do ai nói?",
    options: [
      {
        content: "Nelson Mandela",
        isCorrect: true,
      },
      {
        content: "Mahatma Gandhi",
        isCorrect: false,
      },
      {
        content: "Winston Churchill",
        isCorrect: false,
      },
      {
        content: "Abraham Lincoln",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "d34a9c10-867e-4286-a4e4-0a0b663d3a4e",
    content: "Thành phố nào được mệnh danh là 'Thành phố ánh sáng'?",
    options: [
      {
        content: "London",
        isCorrect: false,
      },
      {
        content: "New York",
        isCorrect: false,
      },
      {
        content: "Paris",
        isCorrect: true,
      },
      {
        content: "Tokyo",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "ba89ae7d-b142-4dca-884c-a7b6302d153e",
    content: "Hành tinh nào có tên gọi 'Hành tinh đỏ'?",
    options: [
      {
        content: "Venus",
        isCorrect: false,
      },
      {
        content: "Mars",
        isCorrect: true,
      },
      {
        content: "Jupiter",
        isCorrect: false,
      },
      {
        content: "Saturn",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "2358fdcf-a464-4909-9447-0b68faafd662",
    content: "Loài động vật nào được coi là loài động vật nhanh nhất trên cạn?",
    options: [
      {
        content: "Cáo",
        isCorrect: false,
      },
      {
        content: "Ngựa",
        isCorrect: false,
      },
      {
        content: "Hươu cao cổ",
        isCorrect: false,
      },
      {
        content: "Báo gấm",
        isCorrect: true,
      },
    ],
  },
  {
    quizId: "768180f1-d5d1-47fc-906d-20f9d0cbc778",
    content: "Vật liệu nào được sử dụng phổ biến để chế tạo kính hiển vi?",
    options: [
      {
        content: "Kim loại",
        isCorrect: false,
      },
      {
        content: "Thủy tinh",
        isCorrect: true,
      },
      {
        content: "Nhựa",
        isCorrect: false,
      },
      {
        content: "Gốm",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "f0d879fa-92b6-4dbb-8063-d26b4c898433",
    content: "Ai là tác giả của cuốn sách '1984'?",
    options: [
      {
        content: "Harper Lee",
        isCorrect: false,
      },
      {
        content: "George Orwell",
        isCorrect: true,
      },
      {
        content: "J.K. Rowling",
        isCorrect: false,
      },
      {
        content: "Aldous Huxley",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "d6e6d274-c973-4b48-b9bf-2c4f91a2fedf",
    content: "Ngày nào là ngày Quốc khánh của Việt Nam?",
    options: [
      {
        content: "2/9",
        isCorrect: true,
      },
      {
        content: "1/5",
        isCorrect: false,
      },
      {
        content: "30/4",
        isCorrect: false,
      },
      {
        content: "10/3",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "1b7c7cae-3667-4618-bf2a-4ce0a83977c2",
    content: "Thể loại nhạc nào được sáng tạo bởi các nghệ sĩ Mỹ và châu Âu vào thập niên 1960?",
    options: [
      {
        content: "Jazz",
        isCorrect: false,
      },
      {
        content: "Rock and roll",
        isCorrect: true,
      },
      {
        content: "Pop",
        isCorrect: false,
      },
      {
        content: "R&B",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "eb607976-55c2-4a3f-95ff-fbdaa6fd8a16",
    content: "Công ty nào nổi tiếng với sản phẩm iPhone?",
    options: [
      {
        content: "Samsung",
        isCorrect: false,
      },
      {
        content: "Apple",
        isCorrect: true,
      },
      {
        content: "Google",
        isCorrect: false,
      },
      {
        content: "Huawei",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "490731fd-df28-4e91-8d9d-5b5d9944add5",
    content: "Tác phẩm nào là một trong những kiệt tác của nghệ thuật Phục Hưng?",
    options: [
      {
        content: "Những vũ điệu của Thời đại Baroque",
        isCorrect: false,
      },
      {
        content: "Mona Lisa",
        isCorrect: true,
      },
      {
        content: "Cảnh tự nhiên của Bắc Âu",
        isCorrect: false,
      },
      {
        content: "Những bức tranh của Van Gogh",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "aed74f22-3d3c-421e-9824-943101fc10f4",
    content: "Tên của thành phố đầu tiên trên thế giới có hệ thống tàu điện ngầm?",
    options: [
      {
        content: "New York",
        isCorrect: false,
      },
      {
        content: "London",
        isCorrect: true,
      },
      {
        content: "Paris",
        isCorrect: false,
      },
      {
        content: "Tokyo",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "ffc6842e-f8a2-40f3-81d2-16e047d2b36e",
    content: "Ai là người phát minh ra bóng đèn điện?",
    options: [
      {
        content: "Nikola Tesla",
        isCorrect: false,
      },
      {
        content: "Thomas Edison",
        isCorrect: true,
      },
      {
        content: "Alexander Graham Bell",
        isCorrect: false,
      },
      {
        content: "Albert Einstein",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "c957864c-42be-4fc3-b0ff-6d91a8b9b777",
    content: "Đại dương nào là lớn nhất thế giới?",
    options: [
      {
        content: "Đại Tây Dương",
        isCorrect: false,
      },
      {
        content: "Thái Bình Dương",
        isCorrect: true,
      },
      {
        content: "Ấn Độ Dương",
        isCorrect: false,
      },
      {
        content: "Bắc Băng Dương",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "70b5e207-7833-43c5-b0a3-747d248d57dd",
    content: "Quốc gia nào có nhiều đảo nhất trên thế giới?",
    options: [
      {
        content: "Na Uy",
        isCorrect: false,
      },
      {
        content: "Thụy Điển",
        isCorrect: false,
      },
      {
        content: "Thái Lan",
        isCorrect: false,
      },
      {
        content: "Indonesia",
        isCorrect: true,
      },
    ],
  },
  {
    quizId: "77f083ce-e0f4-413f-8c3d-931fda92332d",
    content: "Món ăn truyền thống của Nhật Bản là gì?",
    options: [
      {
        content: "Sushi",
        isCorrect: true,
      },
      {
        content: "Tacos",
        isCorrect: false,
      },
      {
        content: "Paella",
        isCorrect: false,
      },
      {
        content: "Kimchi",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "5af47171-ecaf-4aae-a006-da8c5d9b5b0d",
    content: "Thế giới có bao nhiêu lục địa?",
    options: [
      {
        content: "6",
        isCorrect: false,
      },
      {
        content: "7",
        isCorrect: true,
      },
      {
        content: "8",
        isCorrect: false,
      },
      {
        content: "5",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "20086c77-623f-440f-b1f2-233a3a88d1da",
    content: "Ai là người sáng lập Facebook?",
    options: [
      {
        content: "Steve Jobs",
        isCorrect: false,
      },
      {
        content: "Bill Gates",
        isCorrect: false,
      },
      {
        content: "Mark Zuckerberg",
        isCorrect: true,
      },
      {
        content: "Larry Page",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "3dba4eea-099e-4979-94b6-03748c1510e2",
    content: "Quốc gia nào có nền văn hóa nổi bật với áo dài?",
    options: [
      {
        content: "Thái Lan",
        isCorrect: false,
      },
      {
        content: "Việt Nam",
        isCorrect: true,
      },
      {
        content: "Hàn Quốc",
        isCorrect: false,
      },
      {
        content: "Indonesia",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "bca27f2d-4a3d-41cf-af9a-ce577fde8e67",
    content: "Thủ đô của Úc là gì?",
    options: [
      {
        content: "Sydney",
        isCorrect: false,
      },
      {
        content: "Melbourne",
        isCorrect: false,
      },
      {
        content: "Canberra",
        isCorrect: true,
      },
      {
        content: "Perth",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "5ec5c06c-8a80-4533-9cd6-e1da07ef0b3c",
    content: "Ngày nào là ngày Quốc tế Phụ nữ?",
    options: [
      {
        content: "1/5",
        isCorrect: false,
      },
      {
        content: "8/3",
        isCorrect: true,
      },
      {
        content: "10/3",
        isCorrect: false,
      },
      {
        content: "20/10",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "a17e1cf3-80b7-40f1-8bce-0d71dd945f1d",
    content: "Ai là người sáng lập ra Microsoft?",
    options: [
      {
        content: "Steve Jobs",
        isCorrect: false,
      },
      {
        content: "Bill Gates",
        isCorrect: true,
      },
      {
        content: "Larry Page",
        isCorrect: false,
      },
      {
        content: "Elon Musk",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "b270e93a-3267-4d77-aa24-4c625b24d004",
    content: "Biển lớn nhất thế giới là gì?",
    options: [
      {
        content: "Biển Caribe",
        isCorrect: false,
      },
      {
        content: "Biển Đông",
        isCorrect: false,
      },
      {
        content: "Biển Caspi",
        isCorrect: true,
      },
      {
        content: "Biển Bắc",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "2994f5db-66df-466c-aec7-61873b925916",
    content: "Ai là người sáng lập ra Tesla?",
    options: [
      {
        content: "Jeff Bezos",
        isCorrect: false,
      },
      {
        content: "Elon Musk",
        isCorrect: true,
      },
      {
        content: "Bill Gates",
        isCorrect: false,
      },
      {
        content: "Steve Jobs",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "b1b0a3c8-be4d-4d0c-93ec-24e056d517ad",
    content: "Tượng Nữ thần Tự do tọa lạc tại thành phố nào?",
    options: [
      {
        content: "Los Angeles",
        isCorrect: false,
      },
      {
        content: "New York",
        isCorrect: true,
      },
      {
        content: "Washington D.C.",
        isCorrect: false,
      },
      {
        content: "Chicago",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "1684905d-d46c-46c0-a51e-a117859352fe",
    content: "Chất nào được gọi là 'nước mắt của mặt trời'?",
    options: [
      {
        content: "Đá quý",
        isCorrect: false,
      },
      {
        content: "Hổ phách",
        isCorrect: true,
      },
      {
        content: "Vàng",
        isCorrect: false,
      },
      {
        content: "Kim cương",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "c1b21cf1-1927-43a2-8bc4-702b3b109358",
    content: "Loại nhạc nào nổi tiếng với thể loại reggae?",
    options: [
      {
        content: "Jamaica",
        isCorrect: true,
      },
      {
        content: "Brazil",
        isCorrect: false,
      },
      {
        content: "Mỹ",
        isCorrect: false,
      },
      {
        content: "Cuba",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "0779e141-4553-42d5-ace0-fe39a8b2e5ce",
    content: "Tổng diện tích của trái đất là bao nhiêu?",
    options: [
      {
        content: "510 triệu km²",
        isCorrect: true,
      },
      {
        content: "400 triệu km²",
        isCorrect: false,
      },
      {
        content: "350 triệu km²",
        isCorrect: false,
      },
      {
        content: "600 triệu km²",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "f427f382-6665-472c-99f7-a03eebeab6ff",
    content: "Khối lập phương có bao nhiêu mặt?",
    options: [
      {
        content: "4",
        isCorrect: false,
      },
      {
        content: "6",
        isCorrect: true,
      },
      {
        content: "8",
        isCorrect: false,
      },
      {
        content: "12",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "1c702044-bfa6-463a-a10f-1035179562c7",
    content: "Ai là người đầu tiên đi bộ trên Mặt Trăng?",
    options: [
      {
        content: "Yuri Gagarin",
        isCorrect: false,
      },
      {
        content: "Neil Armstrong",
        isCorrect: true,
      },
      {
        content: "Buzz Aldrin",
        isCorrect: false,
      },
      {
        content: "John Glenn",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "7bdbbfe8-4221-4967-a180-5c5f09c34ce0",
    content: "Mùa nào trong năm thường diễn ra lễ hội Halloween?",
    options: [
      {
        content: "Mùa hè",
        isCorrect: false,
      },
      {
        content: "Mùa thu",
        isCorrect: true,
      },
      {
        content: "Mùa đông",
        isCorrect: false,
      },
      {
        content: "Mùa xuân",
        isCorrect: false,
      },
    ],
  },
  {
    quizId: "7165b5dc-8ab3-4e4c-a781-c751cd40a56b",
    content: "Ai là người sáng lập ra Apple?",
    options: [
      {
        content: "Steve Jobs",
        isCorrect: true,
      },
      {
        content: "Mark Zuckerberg",
        isCorrect: false,
      },
      {
        content: "Bill Gates",
        isCorrect: false,
      },
      {
        content: "Elon Musk",
        isCorrect: false,
      },
    ],
  },
];

export const fetchAllQuizzes = () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        message: "get successfully!",
        data: [...dbQuizzes],
      });
    }, 2000);
  });
};

export const addNewQuiz = async (quiz) => {
  const id = crypto.randomUUID();
  quiz.quizId = id;
  dbQuizzes.push(quiz);
  return id;
};

export const editQuiz = async (quiz) => {
  const updateQuiz = { ...quiz };

  const index = dbQuizzes.findIndex((q) => q.id === quiz.id);

  if (index !== -1) {
    dbQuizzes = [
      ...dbQuizzes.slice(0, index),
      { ...dbQuizzes[index], ...updateQuiz },
      ...dbQuizzes.slice(index + 1),
    ];
    return true;
  }
  return false;
};

export const delQuiz = (id) => {
  dbQuizzes = dbQuizzes.filter((q) => q.id != id);
  return true;
};
