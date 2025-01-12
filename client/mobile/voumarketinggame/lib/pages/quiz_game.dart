import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:voumarketinggame/widgets/bottom_nav_quiz.dart';
import 'package:voumarketinggame/widgets/bottom_nav_chart.dart';

class QuizGamePage extends StatefulWidget {
  final String roomName;

  const QuizGamePage({super.key, required this.roomName});

  @override
  // ignore: library_private_types_in_public_api
  _QuizGamePageState createState() => _QuizGamePageState();
}

class _QuizGamePageState extends State<QuizGamePage>
    with TickerProviderStateMixin {
  bool isLiked = false;
  late AnimationController _animationController;
  late bool isPlaying = true; // hide or Not bottom_nav_quiz

  late bool isChart = true; // hide or Not bottom_nav_chart

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        child:
                            Lottie.asset('assets/animations/man_talking.json'),
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
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Question 1:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Trái đất có hình gì ?',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.person, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            '1000',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: _toggleLike,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.6),
                              ),
                            ),
                            Lottie.asset(
                              'assets/animations/heart_icon.json',
                              width: 60,
                              height: 60,
                              fit: BoxFit.fill,
                              controller: _animationController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isPlaying)
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavQuiz(),
            ),
          if (!isChart)
            const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BottomNavStatistics(
                  stats: {
                    'A': 50.0,
                    'B': 20.0,
                    'C': 20.0,
                    'D': 10.0,
                  },
                )),
        ],
      ),
    );
  }
}
