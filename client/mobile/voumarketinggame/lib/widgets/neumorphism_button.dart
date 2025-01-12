import 'package:flutter/material.dart';

class NeumorphismWidget extends StatefulWidget {
  final double height;
  final double width;
  final Color color;
  final BorderRadius borderRadius;
  final Duration duration;
  final IconData icon;
  final Color initialIconColor;
  final Color tappedIconColor;
  final VoidCallback? onTap; // Thêm onTap vào constructor

  const NeumorphismWidget({
    super.key,
    this.height = 200,
    this.width = 200,
    this.color = Colors.grey,
    this.borderRadius = const BorderRadius.all(Radius.circular(50)),
    this.duration = const Duration(milliseconds: 200),
    required this.icon,
    this.initialIconColor = Colors.pink,
    this.tappedIconColor = Colors.grey,
    this.onTap, // Thêm tham số onTap
  });

  @override
  _NeumorphismWidgetState createState() => _NeumorphismWidgetState();
}

class _NeumorphismWidgetState extends State<NeumorphismWidget> {
  bool _isElevated = false;
  bool _isTapped = false;

  void _handleTap() {
    setState(() {
      _isElevated = true; // Bắt đầu hiệu ứng bóng mờ
      _isTapped = true; // Đổi màu icon
    });

    // Đưa về trạng thái ban đầu sau thời gian `widget.duration`
    Future.delayed(widget.duration, () {
      setState(() {
        _isElevated = false; // Tắt hiệu ứng bóng mờ
        _isTapped = false; // Đưa icon về màu ban đầu
      });
    });

    // Gọi callback onTap nếu có
    if (widget.onTap != null) {
      widget.onTap!(); // Gọi onTap từ widget
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap, // Gọi hàm xử lý khi nhấn
      child: AnimatedContainer(
        duration: widget.duration,
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: widget.borderRadius,
          boxShadow: _isElevated
              ? [
                  const BoxShadow(
                    color: Colors.grey,
                    offset: Offset(4, 4),
                    blurRadius: 3,
                    spreadRadius: 1,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4, -4),
                    blurRadius: 3,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Icon(
            widget.icon,
            color: _isTapped ? widget.tappedIconColor : widget.initialIconColor,
            size: 40,
          ),
        ),
      ),
    );
  }
}
