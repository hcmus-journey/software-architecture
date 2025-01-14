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
}
