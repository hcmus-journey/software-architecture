import 'package:flutter/material.dart';

class GameButton extends StatefulWidget {
  final String title;
  final String status;
  final String countdownTime;
  final String image;
  final String dateTime;
  final int onlineCount;
  final VoidCallback onTap;

  const GameButton({
    super.key,
    required this.title,
    required this.status,
    required this.countdownTime,
    required this.image,
    required this.dateTime,
    required this.onlineCount,
    required this.onTap,
  });

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  final bool _isElevated = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isElevated
              ? [
                  BoxShadow(
                    color: const Color(0xFFBEBEBE).withOpacity(0.6),
                    offset: const Offset(10, 10),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.7),
                    offset: const Offset(-10, -10),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ]
              : [
                  BoxShadow(
                    color: const Color(0xFFBEBEBE).withOpacity(0.4),
                    offset: const Offset(6, 6),
                    blurRadius: 25,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.6),
                    offset: const Offset(-6, -6),
                    blurRadius: 25,
                    spreadRadius: 2,
                  ),
                ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    widget.image,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: widget.status == "Playing"
                          ? Colors.red
                          : Colors.green,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      widget.status,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0, // Đặt icon vào góc trên bên phải
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.onlineCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.pink.withOpacity(0.35),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ), // Bo góc dưới trái phải
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time_filled,
                    color: Colors.pinkAccent,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.countdownTime,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    widget.dateTime, // Hiển thị ngày giờ truyền vào
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
