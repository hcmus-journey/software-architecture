import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voumarketinggame/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiServiceAuthentication _apiService = ApiServiceAuthentication();
  // Sign Up
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Sign In
  String? _accessToken;
  String? _refreshToken;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  Future<bool> signUp({
    required String username,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _apiService.signUp(
      username: username,
      password: password,
    );

    _isLoading = false;

    if (result.containsKey('error')) {
      _errorMessage = result['message'];
      notifyListeners();
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<void> login({
    required String username,
    required String password
    }) async {
    try {
      final tokens = await _apiService.login(
        username: username,
        password: password
        );

      _accessToken = tokens["accessToken"];
      _refreshToken = tokens["refreshToken"];


      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("accessToken", _accessToken!);
      await prefs.setString("refreshToken", _refreshToken!);

      notifyListeners();
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("accessToken");
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("refreshToken");
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("accessToken");
    await prefs.remove("refreshToken");
    _accessToken = null;
    _refreshToken = null;
    notifyListeners();
  }
}
