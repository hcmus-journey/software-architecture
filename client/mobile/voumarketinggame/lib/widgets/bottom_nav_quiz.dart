import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_sound/flutter_sound.dart';

class BottomNavQuiz extends StatefulWidget {
  final List<String> options;
  final Function(String) onAnswerSelected;
  final int eachQuestionCountDown; // Callback khi trả lời

  const BottomNavQuiz(
      {super.key,
      required this.options,
      required this.onAnswerSelected,
      required this.eachQuestionCountDown});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavQuizState createState() => _BottomNavQuizState();
}

class _BottomNavQuizState extends State<BottomNavQuiz> {
  final CountDownController _controller = CountDownController();
  String? _selectedOption; // Biến lưu trạng thái đáp án đã chọn
  late FlutterSoundPlayer _soundEffectPlayer;

  @override
  void initState() {
    super.initState();
    _soundEffectPlayer = FlutterSoundPlayer();
    _controller.restart(); // Khởi động lại bộ đếm khi bắt đầu
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

  Future<void> _playAnswerClickSounds() async {
    try {
      await _playSound('answer_click.wav');
    } catch (e) {
      //print('Lỗi khi phát chuỗi âm thanh: $e');
    }
  }

  void _onQuestionChanged() {
    setState(() {
      _selectedOption = null; // Reset lựa chọn đáp án khi đổi câu hỏi
    });
    _controller.restart(); // Khởi động lại bộ đếm thời gian khi đổi câu hỏi
  }

  @override
  void dispose() {
    _soundEffectPlayer.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularCountDownTimer(
              duration: widget.eachQuestionCountDown,
              initialDuration: 0,
              controller: _controller,
              width: MediaQuery.of(context).size.width / 6,
              height: MediaQuery.of(context).size.width / 6,
              ringColor: Colors.grey[300]!,
              fillColor: Colors.pink,
              strokeWidth: 10.0,
              strokeCap: StrokeCap.round,
              textStyle: const TextStyle(
                fontSize: 20.0,
                color: Colors.pink, // Thay đổi màu số trong bộ đếm thành hồng
                fontWeight: FontWeight.bold,
              ),
              isReverse: true,
              isReverseAnimation: true,
              isTimerTextShown: true,
              autoStart: true,
              onComplete: () {
                _onQuestionChanged(); // Gọi khi hết thời gian
              },
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10, // Khoảng cách giữa các mục
              runSpacing: 10, // Khoảng cách giữa các dòng
              children: widget.options.map((option) {
                final isSelected = _selectedOption == option;
                return GestureDetector(
                  onTap: _selectedOption == null
                      ? () {
                          _playAnswerClickSounds(); // Phát âm thanh khi chọn đáp án
                          setState(() {
                            _selectedOption = option; // Lưu đáp án đã chọn
                          });
                          widget.onAnswerSelected(
                              option); // Gửi đáp án cho QuizGamePage
                        }
                      : null, // Không cho phép chọn lại nếu đã chọn
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _selectedOption != null || isSelected
                        ? 0.5
                        : 1.0, // Loại bỏ hiệu ứng mờ, tất cả các đáp án đều có độ mờ 1 khi không chọn
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 60) / 2,
                      height: 60, // Chiều cao cố định cho mỗi đáp án
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.green
                            : Colors
                                .white, // Nền xanh lá khi được chọn, nền trắng khi chưa chọn
                        border: Border.all(
                            color: Colors.pink, width: 2), // Viền nút màu hồng
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
