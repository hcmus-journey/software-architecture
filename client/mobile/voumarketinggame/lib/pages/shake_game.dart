import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:voumarketinggame/services/game_service.dart';
import 'package:voumarketinggame/providers/auth_provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:voumarketinggame/widgets/game_state.dart';
import 'package:voumarketinggame/widgets/global_event.dart';

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
  late final AnimationController _controller;
  bool _isCongratulationsVisible = false;
  late ApiServiceGame _apiServiceGame;
  late FlutterSoundPlayer _soundPlayer;
  int remainingGames = 10;
  bool _hasShownSnackBar =
      false; // Biến cờ để kiểm tra SnackBar đã hiển thị hay chưa

  @override
  void initState() {
    super.initState();
    _loadRemainingGames();
    _soundPlayer = FlutterSoundPlayer();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _apiServiceGame = ApiServiceGame();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isShaking = false;
        });
      }
    });
  }

  // Hàm tải giá trị remainingGames
  Future<void> _loadRemainingGames() async {
    await GameState().load(); // Tải giá trị từ SharedPreferences
    setState(() {
      remainingGames = GameState().getRemainingGames(); // Cập nhật lại giá trị
    });
  }

  Future<void> _playSound(String fileName) async {
    try {
      if (!_soundPlayer.isOpen()) {
        await _soundPlayer.openPlayer();
      }

      // Phát âm thanh từ tài nguyên nội bộ
      await _soundPlayer.startPlayer(
        fromURI: 'assets/sounds/$fileName',
        codec: Codec.defaultCodec,
      );
    } catch (e) {
      //print('Lỗi khi phát âm thanh: $e');
    }
  }

  Future<void> _playWinningSounds() async {
    try {
      await _playSound('win_gift.wav');
    } catch (e) {
      //print('Lỗi khi phát chuỗi âm thanh: $e');
    }
  }

  Future<void> _playFailSound() async {
    try {
      await _playSound('fail_gift.wav');
    } catch (e) {
      //print('Lỗi khi phát âm thanh thất bại: $e');
    }
  }

  Future<void> _onSwipe() async {
    // Kiểm tra nếu không còn lượt chơi và chưa hiển thị SnackBar
    if (remainingGames <= 0 && !_hasShownSnackBar) {
      // Hiển thị SnackBar nếu không còn lượt chơi và chưa hiển thị SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Không đủ lượt chơi'),
          duration: Duration(seconds: 1), // Hiển thị trong 10 giây
        ),
      );
      Navigator.of(context).pop(); // Đóng trang game
      setState(() {
        _hasShownSnackBar = true; // Đánh dấu là SnackBar đã hiển thị
      });
      return; // Dừng lại nếu không còn lượt chơi
    }

    if (_isShaking || _isCongratulationsVisible) {
      return; // Nếu game đang chơi hoặc có animation chúc mừng, không làm gì
    }

    setState(() {
      _isShaking = true;
      // Giảm lượt chơi khi vào game
      GameState().decrementRemainingGames(); // Giảm lượt chơi trong GameState
      _loadRemainingGames(); // Cập nhật lại remainingGames sau khi giảm
      _hasShownSnackBar = false; // Đặt lại cờ khi có lượt chơi mới
    });

    _controller.forward(from: 0.0);

    try {
      // Gọi API startShakeGame
      final authorizationToken = await AuthProvider().getAccessToken();
      final isDrop = await _apiServiceGame.startShakeGame(
        eventId: GlobalEvent.instance.currentEvent!.eventId,
        authorizationToken: authorizationToken!,
      );

      setState(() {
        _isShaking = false;
      });

      if (isDrop) {
        setState(() {
          _isCongratulationsVisible = true; // Kích hoạt animation
        });

        // Phát chuỗi âm thanh khi trúng thưởng
        await _playWinningSounds();

        // Hiển thị animation chúc mừng và hộp thoại
        Future.delayed(const Duration(seconds: 1), () {
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Chúc mừng!"),
              content: const Text("Bạn nhận được 1 coin"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _isCongratulationsVisible = false;
                    });
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        });
      } else {
        // Phát âm thanh khi không trúng thưởng
        await _playFailSound();

        // Hiển thị thông báo "may mắn lần sau"
        Future.delayed(const Duration(seconds: 1), () {
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Rất tiếc!"),
              content: const Text("Chúc bạn may mắn lần sau!"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _isCongratulationsVisible = false;
                    });
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        });
      }
    } catch (error) {
      setState(() {
        _isShaking = false;
      });
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Lỗi"),
          content: const Text("Không thể kết nối đến máy chủ!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _soundPlayer.closePlayer();
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
                      if (details.primaryDelta! > 0) {
                        _onSwipe();
                      }
                    },
                    onVerticalDragUpdate: (details) {
                      if (details.primaryDelta! > 0) {
                        _onSwipe();
                      }
                    },
                    child: LottieBuilder.asset(
                      'assets/animations/shaking_present.json',
                      controller: _controller,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.8,
                      repeat: false,
                    ),
                  ),
                  const SizedBox(height: 20),
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
                    child: const Text(
                      'Swipe your screen!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isCongratulationsVisible)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Lottie.asset(
                  'assets/animations/congratulation.json',
                  fit: BoxFit.cover,
                  repeat: false,
                  onLoaded: (composition) {
                    Future.delayed(composition.duration, () {});
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
