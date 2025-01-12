import 'package:flutter/material.dart';
import 'neumorphism_button.dart';

class InviteBottomSheet extends StatefulWidget {
  const InviteBottomSheet({super.key});

  @override
  State<InviteBottomSheet> createState() => _InviteBottomSheetState();
}

class _InviteBottomSheetState extends State<InviteBottomSheet> {
  @override
  void initState() {
    super.initState();
    // Hiển thị BottomSheet ngay khi màn hình được xây dựng
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showInviteBottomSheet();
    });
  }

  void _showInviteBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Cho phép cuộn nếu nội dung lớn
      barrierColor: Colors.transparent, // Loại bỏ nền phía sau
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Nút tắt ở góc trái
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Đóng BottomSheet khi nhấn nút đóng
                    Navigator.of(context).pop(); // Đóng luôn trang hiện tại
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Tiêu đề INVITE
              const Text(
                'INVITE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
              const SizedBox(height: 40),
              // Row chứa 2 nút cùng một hàng
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nút Facebook - Neumorphism
                  NeumorphismWidget(
                    icon: Icons.facebook,
                    initialIconColor: Colors.pinkAccent,
                    tappedIconColor: Colors.grey,
                    height: 80,
                    width: 80,
                    color: Colors.grey[300]!,
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      // Đây là callback khi nút được nhấn
                      print("Nút Facebook được nhấn!");
                    },
                  ),
                  const SizedBox(width: 20), // Khoảng cách giữa 2 nút
                  // Nút Share - Neumorphism
                  NeumorphismWidget(
                    icon: Icons.share,
                    initialIconColor: Colors.pinkAccent,
                    tappedIconColor: Colors.grey,
                    height: 80,
                    width: 80,
                    color: Colors.grey[300]!,
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      // Đây là callback khi nút được nhấn
                      print("Nút Share được nhấn!");
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      // Đảm bảo thoát luôn trang nếu người dùng vuốt để đóng BottomSheet
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Trả về Container trống để widget không hiển thị giao diện nền
    return const SizedBox.shrink();
  }
}
