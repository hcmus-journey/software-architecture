import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:voumarketinggame/models/events_model.dart';
import 'package:voumarketinggame/providers/auth_provider.dart';
import 'package:voumarketinggame/services/events_service.dart';

class EventProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<EventModel> _events = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<EventModel> get events => _events;

  List<EventModel> _favorites = []; // Danh sách yêu thích
  List<EventModel> get favorites => _favorites;

  Future<void> fetchAllEvents(BuildContext context) async {
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
        return;
      }
      print("[fetchUserProfile] Access token: $token");

      final EventService apiService = EventService();
      final result = await apiService.getAllEvents(token: token);

      if (result.isNotEmpty) {
        _events = result.map((e) => EventModel.fromJson(e)).toList();
      } else {
        _errorMessage = "No events found.";
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<EventModel> getEventsByBrand(String brandId) {
  return _events.where((event) => event.brandId == brandId).toList();
  }

  Future<void> addToFavorite(BuildContext context, String eventId) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = await authProvider.getAccessToken();

      if (token == null) {
        throw Exception("Access token not found.");
      }

      final EventService apiService = EventService();
      await apiService.addEventToFavorite(eventId: eventId, token: token);

      await fetchFavoriteEvents(context);
      notifyListeners();
    } catch (e) {
      print("Error adding to favorite: $e");
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Hàm xóa khỏi danh sách yêu thích
  Future<void> removeFromFavorite(BuildContext context, String eventId) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = await authProvider.getAccessToken();

      if (token == null) {
        throw Exception("Access token not found.");
      }

      final EventService apiService = EventService();
      await apiService.removeFromFavorite(token: token, eventId: eventId);

      await fetchFavoriteEvents(context);
      //notifyListeners();
    } catch (e) {
      print("Error while removing favorite: $e");
      throw e;
    }
  }

 
  bool isEventFavorite(String eventId) {
    return _favorites.any((event) => event.eventId == eventId);
  }


  Future<void> fetchFavoriteEvents(BuildContext context) async {
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

    final EventService apiService = EventService();
    final result = await apiService.fetchFavoriteEvents(token: token);

    _favorites = result.map((e) => EventModel.fromJson(e)).toList();
  } catch (e) {
    
    _errorMessage = e.toString();
  } finally {
    // Tắt loading
    _isLoading = false;
    notifyListeners();
  }
}


EventModel? getEventById(String eventId) {
  try {
    return _events.firstWhere((event) => event.eventId == eventId);
  } catch (e) {
 
    return null;
  }
}




}
