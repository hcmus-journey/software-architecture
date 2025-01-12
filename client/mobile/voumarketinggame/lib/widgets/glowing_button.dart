import 'package:flutter/material.dart';

class GlowingButton extends StatefulWidget {
  final Color color1;
  final Color color2;
  final VoidCallback onTap; // Thêm tham số onTap

  const GlowingButton(
      {required Key key,
      this.color1 = Colors.blue,
      this.color2 = Colors.pinkAccent,
      required this.onTap}) // Yêu cầu tham số onTap
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GlowingButtonState createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton> {
  var glowing = true;
  var scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (val) {
        setState(() {
          glowing = false;
          scale = 1.0;
        });
      },
      onTapDown: (val) {
        setState(() {
          glowing = true;
          scale = 1.1;
        });
      },
      onTap: widget.onTap, // Gọi hàm onTap khi nhấn vào button
      child: AnimatedContainer(
        transform: Matrix4.identity()..scale(scale),
        duration: const Duration(milliseconds: 200),
        height: 40,
        width: 160,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
              colors: [
                widget.color1,
                widget.color2,
              ],
            ),
            boxShadow: glowing
                ? [
                    BoxShadow(
                      color: widget.color1.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 16,
                      offset: const Offset(-8, 0),
                    ),
                    BoxShadow(
                      color: widget.color2.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 16,
                      offset: const Offset(8, 0),
                    ),
                    BoxShadow(
                      color: widget.color1.withOpacity(0.2),
                      spreadRadius: 16,
                      blurRadius: 32,
                      offset: const Offset(-8, 0),
                    ),
                    BoxShadow(
                      color: widget.color2.withOpacity(0.2),
                      spreadRadius: 16,
                      blurRadius: 32,
                      offset: const Offset(8, 0),
                    )
                  ]
                : []),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              glowing ? Icons.add_circle : Icons.add_circle_outline,
              color: Colors.white,
            ),
            Text(
              glowing ? "10" : "10",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
