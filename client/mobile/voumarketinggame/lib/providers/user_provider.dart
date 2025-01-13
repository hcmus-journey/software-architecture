import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voumarketinggame/services/user_service.dart';
import 'package:voumarketinggame/providers/auth_provider.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

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
}
