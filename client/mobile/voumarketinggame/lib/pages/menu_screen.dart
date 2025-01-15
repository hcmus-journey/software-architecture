import 'package:flutter/material.dart';
import 'package:voumarketinggame/widgets/game_state.dart';
import 'dart:async';
import 'package:voumarketinggame/widgets/glowing_button.dart';
import 'package:voumarketinggame/widgets/game_button.dart';
import 'package:voumarketinggame/widgets/invite_bot_nav.dart';
import 'package:voumarketinggame/widgets/countdown_game.dart';
import 'package:voumarketinggame/widgets/global_event.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int remainingGames = 10;

  // Tạo biến countdown riêng biệt cho Quiz và Shake
  String countdownQuiz = "00:03"; // Thời gian đếm ngược cho Quiz
  String countdownShake = "00:03"; // Thời gian đếm ngược cho Shake

  late Timer _timerQuiz;
  late Timer _timerShake;
  late Timer _timerRefresh; // Timer cho việc làm mới `remainingGames`

  int _secondsLeftQuiz = 3; // Số giây còn lại cho Quiz
  int _secondsLeftShake = 3; // Số giây còn lại cho Shake

  @override
  void initState() {
    super.initState();
    _loadRemainingGames();
    _startCountdownQuiz();
    _startCountdownShake();

    // Tạo Timer để làm mới remainingGames mỗi 5 giây
    _timerRefresh = Timer.periodic(const Duration(seconds: 5), (timer) {
      _loadRemainingGames(); // Làm mới giá trị mỗi 5 giây
    });
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
    _timerRefresh.cancel(); // Hủy timer làm mới khi widget bị hủy
    super.dispose();
  }

  // Hàm tải giá trị remainingGames
  Future<void> _loadRemainingGames() async {
    await GameState().load(); // Tải giá trị từ SharedPreferences
    setState(() {
      remainingGames = GameState().getRemainingGames(); // Cập nhật lại giá trị
    });
  }

  // Hàm xử lý chuyển đến trang game Quiz hoặc Shake
  void _navigateToGame(String game) {
    String gameTitle = "";
    String countdownTime = "";

    // Giảm lượt chơi cho mỗi trò chơi
    if (game == "Quiz") {
      if (remainingGames <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Không đủ lượt chơi'),
            duration: Duration(seconds: 1), // Hiển thị trong 1 giây
          ),
        );
      } else {
        // Giảm lượt chơi khi vào game
        GameState().decrementRemainingGames(); // Giảm lượt chơi trong GameState
        _loadRemainingGames(); // Cập nhật lại remainingGames sau khi giảm

        gameTitle = "Quiz Game";
        countdownTime = countdownQuiz; // Sử dụng countdownQuiz cho Quiz

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
    } else if (game == "Shake") {
      gameTitle = "Shake Game";
      countdownTime = countdownShake; // Sử dụng countdownShake cho Shake

      // Pass the game title and countdown time to CountdownGamePage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CountdownGamePage(
            gameTitle: gameTitle,
            countdownTime: countdownTime,
          ),
        ),
      ).then((_) {
        _loadRemainingGames(); // Tải lại giá trị remainingGames
      });
    }
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
          remainingGames: remainingGames, // Truyền số lượt chơi còn lại
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Lặp qua các game và chỉ hiện game có type phù hợp
            ...GlobalEvent.instance
                .getCurrentEvent()!
                .games
                .where((game) => game.type == "QUIZ")
                .map((game) {
              return GameButton(
                title: "[Quiz] ${game.name}",
                status: "JOIN NOW",
                countdownTime: countdownQuiz,
                dateTime: GlobalEvent.instance.getCurrentEvent()!.startTime,
                image: game.imageUrl,
                onlineCount: 5,
                onTap: () => _navigateToGame("Quiz"),
              );
            }),
            const SizedBox(height: 16),
            // Shake game
            ...GlobalEvent.instance
                .getCurrentEvent()!
                .games
                .where((game) => game.type == "SHAKE_PHONE")
                .map((game) {
              return GameButton(
                title: "[Shake] ${game.name}",
                status: "JOIN NOW",
                countdownTime: countdownShake,
                dateTime: GlobalEvent.instance.getCurrentEvent()!.startTime,
                image: game.imageUrl,
                onlineCount: 781,
                onTap: () => _navigateToGame("Shake"),
              );
            }),
          ],
        ),
      ),
    );
  }
}
