import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:voumarketinggame/providers/auth_provider.dart';
import 'package:voumarketinggame/models/quiz_model.dart';
import 'package:voumarketinggame/services/game_service.dart';
import 'package:voumarketinggame/widgets/bottom_nav_quiz.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:voumarketinggame/widgets/global_event.dart';

class QuizGamePage extends StatefulWidget {
  final String roomName;

  const QuizGamePage({super.key, required this.roomName});

  @override
  // ignore: library_private_types_in_public_api
  _QuizGamePageState createState() => _QuizGamePageState();
}

// quiz_game.dart

class _QuizGamePageState extends State<QuizGamePage>
    with TickerProviderStateMixin {
  bool isLiked = false;
  late AnimationController _animationController;
  late bool isPlaying = true;
  int correctAnswers = 0; // Số câu trả lời đúng
  List<Quiz> _quizzes = [];
  int currentQuizIndex = 0;
  late Timer _quizTimer;
  int eachQuestionCountDown = 15;
  late FlutterSoundPlayer _soundEffectPlayer;
  late FlutterSoundPlayer _soundPlayer;
  final FlutterTts _flutterTts = FlutterTts();
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _soundEffectPlayer = FlutterSoundPlayer();
    _soundPlayer = FlutterSoundPlayer();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller = AnimationController(vsync: this);
    // Khởi tạo CountDownController
    _fetchQuizzes();
    _playNextQuestionSounds();
    _playTickTacSound();
  }

  @override
  void dispose() {
    _quizTimer.cancel(); // Hủy Timer khi thoát khỏi trang
    _animationController.dispose();
    _controller.dispose();
    _soundPlayer.closePlayer();
    _soundEffectPlayer.closePlayer();
    super.dispose();
  }

  Future<void> _speakQuestion(String question) async {
    await _flutterTts.setLanguage("vi-VN"); // Đặt ngôn ngữ là Tiếng Việt
    await _flutterTts.setSpeechRate(0.5); // Tốc độ nói (tùy chỉnh)

    // Phát âm câu hỏi
    await _flutterTts.speak(question);

    // Khi TTS kết thúc, dừng hoạt ảnh
    _flutterTts.setCompletionHandler(() {
      setState(() {
        _controller.stop();
      });
    });
  }

  Future<void> _playSound(String fileName) async {
    try {
      if (!_soundEffectPlayer.isOpen()) {
        await _soundEffectPlayer.openPlayer();
      }

      // Phát âm thanh từ tài nguyên nội bộ
      await _soundEffectPlayer.startPlayer(
        fromURI: 'assets/sounds/$fileName',
        codec: Codec.defaultCodec,
      );
    } catch (e) {
      //print('Lỗi khi phát âm thanh: $e');
    }
  }

  Future<void> _playTickTacSound() async {
    try {
      if (!_soundPlayer.isOpen()) {
        await _soundPlayer.openPlayer();
      }

      // Phát âm thanh từ tài nguyên nội bộ
      await _soundPlayer.startPlayer(
        fromURI: 'assets/sounds/ticktac.wav',
        codec: Codec.defaultCodec,
      );
    } catch (e) {
      //print('Lỗi khi phát âm thanh: $e');
    }
  }

  Future<void> _playNextQuestionSounds() async {
    try {
      await _playSound('newquestion.wav');
    } catch (e) {
      //print('Lỗi khi phát chuỗi âm thanh: $e');
    }
  }

  Future<void> _playCongratulationSounds() async {
    try {
      await _playSound('claphand.wav');
    } catch (e) {
      //print('Lỗi khi phát chuỗi âm thanh: $e');
    }
  }

  void _fetchQuizzes() async {
    try {
      final apiService = ApiServiceGame();
      final quizzes = await apiService.startQuizGame(
        eventId: GlobalEvent.instance.currentEvent!.eventId,
        authorizationToken: (await AuthProvider().getAccessToken())!,
      );
      setState(() {
        _quizzes = quizzes;
        currentQuizIndex = 0; // Bắt đầu từ câu hỏi đầu tiên
      });

      // Phát âm câu hỏi đầu tiên
      _speakQuestion(_quizzes[currentQuizIndex].content);

      // Set timer để thay đổi câu hỏi sau mỗi eachQuestionCountDown
      _quizTimer =
          Timer.periodic(Duration(seconds: eachQuestionCountDown), (timer) {
        if (currentQuizIndex < _quizzes.length - 1) {
          setState(() {
            currentQuizIndex++;
            _playNextQuestionSounds();
            _playTickTacSound();
            _controller.reset(); // Reset animation before starting again
            _controller.forward(); // Bắt đầu lại hoạt ảnh khi câu hỏi mới
          });
          // Phát âm câu hỏi tiếp theo
          _speakQuestion(_quizzes[currentQuizIndex].content);
        } else {
          timer.cancel(); // Dừng Timer khi hết câu hỏi
          _showCompletionDialog(); // Hiển thị thông báo khi hoàn thành
          _playCongratulationSounds();
        }
      });
    } catch (error) {
      //print('Error fetching quizzes: $error');
    }
  }

  // Hàm xử lý câu trả lời đúng hay sai
  void _checkAnswer(String selectedOption) {
    final quiz = _quizzes[currentQuizIndex];
    final selectedAnswer = quiz.options.firstWhere(
      (option) => option.content == selectedOption,
      orElse: () => Option(
          content: '',
          isCorrect: false), // Đảm bảo không xảy ra lỗi khi không tìm thấy
    );

    if (selectedAnswer.isCorrect) {
      setState(() {
        correctAnswers++;
      });
    }
  }

  // Hiển thị thông báo hoàn thành
  void _showCompletionDialog() async {
    setState(() {
      isPlaying = false; // Ẩn BottomNavQuiz
    });

    String message =
        'Bạn đã trả lời đúng $correctAnswers / ${_quizzes.length} câu hỏi!';
    String title = 'Chúc mừng!';
    bool isSuccess = correctAnswers == _quizzes.length;

    // Nếu tất cả các câu trả lời đúng, gọi API endQuizGame
    if (isSuccess) {
      try {
        final apiService = ApiServiceGame();
        final result = await apiService.endQuizGame(
          eventId: GlobalEvent.instance.currentEvent!.eventId,
          questionCount: _quizzes.length,
          correctAnswerCount: correctAnswers,
          authorizationToken: (await AuthProvider().getAccessToken())!,
        );

        // Lấy thông tin giảm giá từ kết quả trả về
        final discount = result['discount'] ?? 0;
        message =
            'Bạn đã trả lời đúng $correctAnswers / ${_quizzes.length} câu hỏi!\nVoucher giảm $discount% đã gửi về tài khoản.';
      } catch (error) {
        title = 'Lỗi';
        message = 'Không thể hoàn tất yêu cầu. Vui lòng thử lại sau!';
      }
    }

    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSuccess ? Colors.green : Colors.red,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSuccess ? Colors.pinkAccent : Colors.grey,
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng hộp thoại
                  Navigator.of(context).pop(); // Quay về trang trước đó
                },
                child: const Text(
                  'THOÁT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Phương thức _toggleLike để chuyển đổi trạng thái like
  // void _toggleLike() {
  //   setState(() {
  //     isLiked = !isLiked;
  //     if (isLiked) {
  //       _animationController.forward();
  //     } else {
  //       _animationController.reverse();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (_quizzes.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final quiz = _quizzes[currentQuizIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          widget.roomName,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.pink,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 105, 180),
                          border: Border.all(color: Colors.white, width: 10),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Lottie.asset(
                          'assets/animations/man_talking.json', // Đường dẫn tới tệp JSON của hoạt ảnh Lottie
                          controller:
                              _controller, // Sử dụng controller để điều khiển hoạt ảnh
                          onLoaded: (composition) {
                            // Thiết lập thời gian của AnimationController bằng thời gian của hoạt ảnh
                            _controller
                              ..duration = composition.duration
                              ..forward(); // Bắt đầu hoạt ảnh
                          },
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/quiz_banner.png'),
                                radius: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Owner Name',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: const Color.fromARGB(255, 255, 182, 193),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Question ${currentQuizIndex + 1}:',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                quiz.content,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            '5',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // GestureDetector(
                      //   onTap: _toggleLike,
                      //   child: Stack(
                      //     alignment: Alignment.center,
                      //     children: [
                      //       Container(
                      //         width: 60,
                      //         height: 60,
                      //         decoration: BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           color: Colors.white.withOpacity(0.6),
                      //         ),
                      //       ),
                      //       Lottie.asset(
                      //         'assets/animations/heart_icon.json',
                      //         width: 60,
                      //         height: 60,
                      //         fit: BoxFit.fill,
                      //         controller: _animationController,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isPlaying)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavQuiz(
                options: quiz.options.map((option) => option.content).toList(),
                onAnswerSelected: (selectedOption) {
                  _checkAnswer(selectedOption);
                },
                eachQuestionCountDown: eachQuestionCountDown,
              ),
            ),
        ],
      ),
    );
  }
}
