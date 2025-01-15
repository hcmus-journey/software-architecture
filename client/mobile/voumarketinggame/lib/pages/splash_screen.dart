import 'package:flutter/material.dart';
import 'package:voumarketinggame/pages/menu_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Tạo AnimationController cho hiệu ứng fade-in
    _animationController = AnimationController(
      duration: const Duration(seconds: 2), // Thời gian fade-in
      vsync: this,
    )..forward(); // Bắt đầu hiệu ứng fade-in

    // Tự động chuyển sang màn hình Menu sau 5 giây
    Future.delayed(const Duration(seconds: 2), () {
      _navigateToMenu();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Hàm điều hướng đến màn hình Menu
  void _navigateToMenu() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MenuPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animationController,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash.png'),
              fit: BoxFit.cover, // Ảnh tràn toàn màn hình
            ),
          ),
        ),
      ),
    );
  }
}
