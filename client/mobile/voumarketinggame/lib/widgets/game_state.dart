import 'package:shared_preferences/shared_preferences.dart';

class GameState {
  static final GameState _instance = GameState._internal();
  int remainingGames = 10; // Giá trị mặc định là 10

  factory GameState() {
    return _instance;
  }

  GameState._internal();

  // Hàm tải giá trị remainingGames từ SharedPreferences
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    remainingGames = prefs.getInt('remainingGames') ??
        10; // Nếu không có giá trị lưu trữ thì lấy 10
  }

  // Hàm lưu giá trị remainingGames vào SharedPreferences
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('remainingGames', remainingGames);
  }

  // Hàm trả về remainingGames
  int getRemainingGames() {
    return remainingGames;
  }

  // Hàm cộng 1 vào remainingGames và lưu lại
  Future<void> incrementRemainingGames() async {
    remainingGames++;
    await save(); // Lưu lại giá trị mới vào SharedPreferences
  }

  // Hàm trừ 1 vào remainingGames và lưu lại
  Future<void> decrementRemainingGames() async {
    if (remainingGames > 0) {
      remainingGames--;
      await save(); // Lưu lại giá trị mới vào SharedPreferences
    }
  }
}
