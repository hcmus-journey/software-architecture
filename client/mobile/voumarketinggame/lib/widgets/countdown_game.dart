import 'package:flutter/material.dart';
import 'dart:async';
import 'package:voumarketinggame/pages/quiz_game.dart';
import 'package:voumarketinggame/pages/shake_game.dart';

class CountdownGamePage extends StatefulWidget {
  final String gameTitle; // Tiêu đề game
  final String countdownTime; // Thời gian đếm ngược

  const CountdownGamePage(
      {super.key,
      required this.gameTitle,
      required this.countdownTime}); // Thêm countdownTime

  @override
  // ignore: library_private_types_in_public_api
  _CountdownGamePageState createState() => _CountdownGamePageState();
}

class _CountdownGamePageState extends State<CountdownGamePage>
    with TickerProviderStateMixin {
  late Timer _timer;
  late int _secondsLeft;
  late AnimationController _animationController;
  late AnimationController _scaleController; // Controller cho animation thu nhỏ
  late Animation<double> _scaleAnimation; // Animation thu nhỏ

  @override
  void initState() {
    super.initState();
    _startCountdown();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Animation thu nhỏ màn hình countdown khi hết thời gian
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    // Chuyển đổi countdownTime từ định dạng "mm:ss" thành giây
    _secondsLeft = _convertToSeconds(widget.countdownTime);
  }

  // Chuyển đổi thời gian "mm:ss" thành giây
  int _convertToSeconds(String time) {
    List<String> parts = time.split(":");
    int minutes = int.parse(parts[0]);
    int seconds = int.parse(parts[1]);
    return minutes * 60 + seconds;
  }

  // Logic đếm ngược thời gian
  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() {
          _secondsLeft--;
        });
      } else {
        _timer.cancel();
        _onCountdownFinished();
      }
    });
  }

  // Khi countdown hoàn thành
  void _onCountdownFinished() {
    // Bắt đầu animation thu nhỏ
    _scaleController.forward().then((value) {
      // Sau khi thu nhỏ xong, chuyển sang trang QuizGame hoặc ShakeGame
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget.gameTitle == "Quiz Game"
              ? QuizGamePage(roomName: widget.gameTitle)
              : ShakeGame(roomName: widget.gameTitle),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _secondsLeft ~/ 60;
    int seconds = _secondsLeft % 60;
    String formattedTime =
        "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.gameTitle, // Sử dụng gameTitle từ MenuPage
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Floating countdown text
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Center(
                    child: Text(
                      formattedTime,
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
