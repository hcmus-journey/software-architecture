import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class BottomNavQuiz extends StatefulWidget {
  const BottomNavQuiz({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavQuizState createState() => _BottomNavQuizState();
}

class _BottomNavQuizState extends State<BottomNavQuiz> {
  final CountDownController _controller = CountDownController();
  String? _selectedOption; // Biến lưu trạng thái đáp án đã chọn

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
              duration: 30,
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
                // Handle timer completion
              },
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10, // Khoảng cách giữa các mục
              runSpacing: 10, // Khoảng cách giữa các dòng
              children: [
                'A.Hình cầu',
                'B.Hình Tam Giác',
                'C.Hình Chữ Nhật',
                'D.Hình Pikachu'
              ].map((option) {
                final isSelected = _selectedOption == option;
                return GestureDetector(
                  onTap: _selectedOption == null
                      ? () {
                          setState(() {
                            _selectedOption = option; // Lưu đáp án đã chọn
                          });
                        }
                      : null, // Không cho phép chọn lại nếu đã chọn
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _selectedOption == null || isSelected
                        ? 1.0
                        : 0.5, // Làm mờ nếu không được chọn
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 60) / 2,
                      height: 60, // Chiều cao cố định cho mỗi đáp án
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.green
                            : Colors.white, // Nền xanh lá khi được chọn
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
