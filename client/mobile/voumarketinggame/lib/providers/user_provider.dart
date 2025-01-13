import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voumarketinggame/models/user_model.dart';
import 'package:voumarketinggame/services/user_service.dart';
import 'package:voumarketinggame/providers/auth_provider.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  User? _user;
  User? get user => _user;

  Future<bool> updateUserActive({
    required Map<String, dynamic> userInfo,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = await authProvider.getAccessToken();

      if (token == null) {
        _errorMessage = "Access token not found.";
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final result = await _userService.updateUserActive(
        token: token,
        userInfo: userInfo,
      );

      if (result.containsKey('error')) {
        _errorMessage = result['message'];
        _isLoading = false;
        notifyListeners();
        return false;
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchUserProfile(BuildContext context) async {
  _isLoading = true;
  _errorMessage = null;
  notifyListeners();

  try {
    print("[fetchUserProfile] Starting fetchUserProfile");
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getAccessToken();
    print("[fetchUserProfile] Access token: $token");

    if (token == null) {
      _errorMessage = "Access token not found.";
      _isLoading = false;
      notifyListeners();
      print("[fetchUserProfile] Error: $_errorMessage");
      return false;
    }

    final result = await _userService.getUserProfile(token: token);
    print("[fetchUserProfile] API Result: $result"); 

    if (result.containsKey('error')) {
      _errorMessage = result['message'];
      _isLoading = false;
      notifyListeners();
      print("[fetchUserProfile] Error: $_errorMessage");
      return false;
    }

    _user = User.fromJson(result);
    print("[fetchUserProfile] Parsed User: ${_user?.toJson()}"); 
    _isLoading = false;
    notifyListeners();
    print("[fetchUserProfile] Successfully fetched user profile");
    return true;
  } catch (e) {
    _errorMessage = e.toString();
    _isLoading = false;
    notifyListeners();
    print("[fetchUserProfile] Exception: $_errorMessage");
    return false;
  }
}


  Future<bool> updateUser({
  required Map<String, dynamic> userInfo,
  required BuildContext context,
  }) async {
  _isLoading = true;
  _errorMessage = null;
  notifyListeners();

  try {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getAccessToken();

    if (token == null) {
      _errorMessage = "Access token not found.";
      _isLoading = false;
      notifyListeners();
      return false;
    }

    final result = await _userService.updateUser(
      token: token,
      userInfo: userInfo,
    );

    if (result.containsKey('error') && result['error'] == true) {
      _errorMessage = result['message'];
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (result.containsKey('name') &&
        result.containsKey('email') &&
        result.containsKey('phoneNumber') &&
        result.containsKey('avatarUrl') &&
        result.containsKey('birthday') &&
        result.containsKey('gender')) {
      _user = User.fromJson(result); 
    } else if (result.containsKey('message')) {
  
      print("Update successful, no user details returned.");
    }

    _isLoading = false;
    notifyListeners();
    return true;
  } catch (e) {
    _errorMessage = e.toString();
    _isLoading = false;
    notifyListeners();
    return false;
  }
}






}
