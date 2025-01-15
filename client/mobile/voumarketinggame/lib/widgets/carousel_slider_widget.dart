import 'dart:async';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({super.key});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  late PageController _pageController;
  late Timer _timer;

  final List<String> _originalImages = [
    'assets/images/fashion.png',
    'assets/images/katinat.png',
    'assets/images/trasuadodo.png',
    'assets/images/toco.png',
    'assets/images/highlands.png',
  ];

  List<String> get _carouselImages {
    return [
      _originalImages.last,
      ..._originalImages,
      _originalImages.first,
    ];
  }

  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      _moveToNextPage();
    });
  }

  void _moveToNextPage() {
    _currentIndex++;
    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _handlePageChange(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        _currentIndex = _originalImages.length;
        _pageController.jumpToPage(_currentIndex);
      } else if (_currentIndex == _carouselImages.length - 1) {
        _currentIndex = 1;
        _pageController.jumpToPage(_currentIndex);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
   
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _handlePageChange,
            itemCount: _carouselImages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    _carouselImages[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
   
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_originalImages.length, (index) {
            final isActive = _currentIndex == index + 1;
            return GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  index + 1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? Colors.pink : Colors.grey.shade400,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
