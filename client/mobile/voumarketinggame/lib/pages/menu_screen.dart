import 'package:flutter/material.dart';
import 'dart:async';
import 'package:voumarketinggame/widgets/glowing_button.dart';
import 'package:voumarketinggame/widgets/game_button.dart';
import 'package:voumarketinggame/widgets/invite_bot_nav.dart';
import 'package:voumarketinggame/widgets/countdown_game.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // Giả sử số lượt chơi còn lại là 10
  int remainingGames = 10;

  // Tạo các biến countdown riêng biệt cho Quiz và Shake
  String countdownQuiz = "00:05"; // Thời gian đếm ngược cho Quiz
  String countdownShake = "00:03"; // Thời gian đếm ngược cho Shake

  late Timer _timerQuiz;
  late Timer _timerShake;

  int _secondsLeftQuiz = 5; // Số giây còn lại cho Quiz
  int _secondsLeftShake = 3; // Số giây còn lại cho Shake

  @override
  void initState() {
    super.initState();
    _startCountdownQuiz();
    _startCountdownShake();
  }

  // Hàm đếm ngược thời gian cho Quiz
  void _startCountdownQuiz() {
    _timerQuiz = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeftQuiz > 0) {
        setState(() {
          _secondsLeftQuiz--;
          int minutes = _secondsLeftQuiz ~/ 60;
          int seconds = _secondsLeftQuiz % 60;
          countdownQuiz =
              "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
        });
      } else {
        _timerQuiz.cancel();
      }
    });
  }

  // Hàm đếm ngược thời gian cho Shake
  void _startCountdownShake() {
    _timerShake = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeftShake > 0) {
        setState(() {
          _secondsLeftShake--;
          int minutes = _secondsLeftShake ~/ 60;
          int seconds = _secondsLeftShake % 60;
          countdownShake =
              "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
        });
      } else {
        _timerShake.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timerQuiz.cancel();
    _timerShake.cancel();
    super.dispose();
  }

  // Hàm xử lý chuyển đến trang game Quiz hoặc Shake
  void _navigateToGame(String game) {
    String gameTitle = "";
    String countdownTime = "";

    // Set the title and countdown time based on the selected game
    if (game == "Quiz") {
      gameTitle = "Quiz Game";
      countdownTime = countdownQuiz; // Sử dụng countdownQuiz cho Quiz
    } else if (game == "Shake") {
      gameTitle = "Shake Game";
      countdownTime = countdownShake; // Sử dụng countdownShake cho Shake
    }

    // Pass the game title and countdown time to CountdownGamePage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountdownGamePage(
          gameTitle: gameTitle,
          countdownTime: countdownTime,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink, // Màu nền appbar là pink
        leadingWidth: 50, // Giảm chiều rộng của icon back
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Quay lại màn hình trước
          },
        ),
        centerTitle: true,
        title: GlowingButton(
          color1: Colors.lightGreen,
          color2: Colors.pinkAccent,
          key: UniqueKey(),
          onTap: () {
            // Xử lý sự kiện khi nhấn vào nút
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const InviteBottomSheet();
              },
            );
          },
        ),
      ),
      //backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Nút Quiz Game
            GameButton(
              title: "[Quiz] Chinh Phục Kiến Thức",
              status: "Playing",
              countdownTime: countdownQuiz, // Sử dụng countdownQuiz cho Quiz
              dateTime: "24/12/2024 14:30",
              image: 'images/quiz_banner.png',
              onlineCount: 500,
              onTap: () => _navigateToGame("Quiz"),
            ),
            const SizedBox(height: 16),
            // Nút Shake Game
            GameButton(
              title: "[Shake] Lắc Thật Mạnh, Nhận Quà Thật To",
              status: "Waiting",
              countdownTime: countdownShake, // Sử dụng countdownShake cho Shake
              dateTime: "24/12/2024 14:30",
              image: 'images/shake_banner.png',
              onlineCount: 1000,
              onTap: () => _navigateToGame("Shake"),
            )
          ],
        ),
      ),
    );
  }
}
