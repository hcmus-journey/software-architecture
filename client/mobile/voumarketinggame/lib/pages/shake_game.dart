import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ShakeGame extends StatefulWidget {
  final String roomName;

  const ShakeGame({super.key, required this.roomName});

  @override
  // ignore: library_private_types_in_public_api
  _ShakeGamePageState createState() => _ShakeGamePageState();
}

class _ShakeGamePageState extends State<ShakeGame>
    with TickerProviderStateMixin {
  bool _isShaking = false;
  late final AnimationController _controller; // Declare controller
  bool _isCongratulationsVisible =
      false; // Track if congratulation animation should be shown

  @override
  void initState() {
    super.initState();
    // Initialize the controller with duration and vsync
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    // Add listener to reset _isShaking when animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isShaking = false; // Reset shaking flag when animation completes
          _isCongratulationsVisible =
              true; // Show congratulation animation after shaking
        });
      }
    });
  }

  // Function to be called when the swipe gesture is detected
  void _onSwipe() {
    if (!_isShaking && !_isCongratulationsVisible) {
      setState(() {
        _isShaking = true; // Set shaking state to true
      });

      // Play the shaking animation when swipe is detected
      _controller.forward(from: 0.0); // Start animation
    }
  }

  // Function to show the congratulatory dialog after animation
  void _onShakeComplete() {
    // Show the congratulatory dialog after the animation
    Future.delayed(const Duration(seconds: 1), () {
      // Show the congratulatory dialog
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Chúc mừng!"),
          content: const Text("Bạn nhận được 1 coin"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Hide the congratulation animation overlay
                setState(() {
                  _isCongratulationsVisible = false; // Hide the overlay
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Text(
          widget.roomName,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      // Detect horizontal swipe (swipe left or right)
                      if (details.primaryDelta! > 0) {
                        _onSwipe();
                      }
                    },
                    onVerticalDragUpdate: (details) {
                      // Detect vertical swipe (swipe up or down)
                      if (details.primaryDelta! > 0) {
                        _onSwipe();
                      }
                    },
                    child: LottieBuilder.asset(
                      'assets/animations/shaking_present.json',
                      controller: _controller, // Attach the controller
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.8,
                      repeat: false,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Add text box with "Swipe your screen!" message
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    decoration: const BoxDecoration(
                      color: Colors.pinkAccent,
                      border: Border(
                        top: BorderSide(color: Colors.lightGreen),
                        bottom: BorderSide(color: Colors.lightGreen),
                      ),
                    ),
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: [
                            Colors.white.withOpacity(
                                1), // White color with opacity 1 in the middle
                            Colors.white.withOpacity(
                                0.2), // White with opacity 0.2 on the sides
                            Colors.white.withOpacity(
                                1), // White with opacity 1 in the middle
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcATop,
                      child: Container(
                        alignment: Alignment.center,
                        width:
                            double.infinity, // Stretch text across the screen
                        child: const Text(
                          'Swipe your screen!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Display the congratulation animation if needed
          if (_isCongratulationsVisible)
            Positioned.fill(
              child: Container(
                color:
                    Colors.black.withOpacity(0.5), // Semi-transparent overlay
                child: Lottie.asset(
                  'assets/animations/congratulation.json',
                  fit: BoxFit.cover,
                  repeat: false,
                  onLoaded: (composition) {
                    // Show dialog after the congratulation animation finishes
                    Future.delayed(const Duration(seconds: 0), () {
                      _onShakeComplete();
                    });
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
