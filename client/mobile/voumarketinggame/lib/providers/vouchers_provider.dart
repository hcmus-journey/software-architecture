import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voumarketinggame/models/vouchers_model.dart';
import 'package:voumarketinggame/providers/auth_provider.dart';
import 'package:voumarketinggame/services/vouchers_service.dart';

class VoucherProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<VoucherModel> _vouchers = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<VoucherModel> get vouchers => _vouchers;

  Future<void> fetchVouchers(BuildContext context) async {
  _isLoading = true;
  _errorMessage = null; // Xóa thông báo lỗi nếu có
  notifyListeners(); // Cập nhật giao diện loading

  try {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getAccessToken();

    if (token == null) {
      // Nếu không có token thì chỉ set lỗi và dừng hàm
      _errorMessage = "Access token not found.";
      _isLoading = false;
      notifyListeners();
      return;
    }

    final VoucherService apiService = VoucherService();
    final result = await apiService.fetchVouchers(token: token);

    // Map dữ liệu từ API sang model
    _vouchers = result.map((e) => VoucherModel.fromJson(e)).toList();
  } catch (e) {
    // Ghi nhận lỗi nếu có
    _errorMessage = e.toString();
  } finally {
    // Tắt loading
    _isLoading = false;
    notifyListeners();
  }
}

}
