import 'package:flutter/material.dart';
import 'package:voumarketinggame/services/inventory_service.dart';

class InventoryProvider extends ChangeNotifier {
  final InventoryService _inventoryService;

  // Biến lưu trữ danh sách inventory hiện tại
  List<Map<String, dynamic>> _inventories = [];
  List<Map<String, dynamic>> get inventories => _inventories;

  // Biến lưu trữ inventoryId của inventory được chọn
  String? _currentInventoryId;
  String? get currentInventoryId => _currentInventoryId;

  // Biến để quản lý trạng thái tải dữ liệu
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  InventoryProvider({required InventoryService inventoryService})
      : _inventoryService = inventoryService;

  // Hàm fetch inventory
  Future<void> fetchInventories(String authToken) async {
    _isLoading = true;
    notifyListeners(); // Thông báo cho các widget lắng nghe

    try {
      // Lấy danh sách inventories từ API
      _inventories = await _inventoryService.fetchInventories(authToken);

      // Lưu lại inventoryId từ phản hồi nếu có
      if (_inventories.isNotEmpty) {
        // Giả sử bạn muốn lưu inventoryId của item đầu tiên
        _currentInventoryId = _inventories[0]['inventoryId'];
      }

      _errorMessage = null; // Reset thông báo lỗi nếu fetch thành công
    } catch (error) {
      _errorMessage = error.toString(); // Lưu thông báo lỗi nếu có lỗi
    } finally {
      _isLoading = false;
      notifyListeners(); // Cập nhật lại UI
    }
  }

  // Hàm gọi API gift coin trong Provider
  Future<void> giftCoin(
    String inventoryId,
    String authToken,
    String eventId,
    int coins,
    String receiverId,
  ) async {
    try {
      // Gọi service để thực hiện gift coin
      await _inventoryService.giftCoin(
          inventoryId, authToken, eventId, coins, receiverId);

      notifyListeners(); // Cập nhật UI
    } catch (error) {
      // Xử lý lỗi và cập nhật trạng thái lỗi
      _errorMessage = error.toString();
      notifyListeners(); // Thông báo thay đổi trạng thái để cập nhật UI
    }
  }

  // Hàm gọi API exchange coin
  Future<void> exchangeCoin(String inventoryId, String authToken) async {
    try {
      await _inventoryService.exchangeCoin(inventoryId, authToken);
      // Cập nhật lại sau khi trao đổi thành công
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }
  }
}
