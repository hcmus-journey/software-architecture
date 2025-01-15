import 'dart:convert';
import 'package:http/http.dart' as http;

class EventService {
  static const String _baseUrl = "http://localhost:8080";

  Future<List<Map<String, dynamic>>> getAllEvents(
      {required String token}) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/api/events"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("Response status: ${response.statusCode}");
      print("Raw Response body: ${response.body}");

      if (response.statusCode == 200) {
        // Giải mã UTF-8
        final decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as List;
        print("Decoded Response body: $decodedResponse");

        return List<Map<String, dynamic>>.from(decodedResponse);
      } else {
        throw Exception('Failed to fetch events: ${response.body}');
      }
    } catch (e) {
      print("Error occurred while fetching events: $e");
      return [];
    }
  }

  Future<void> addEventToFavorite({
    required String eventId,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/api/events/$eventId/favorite"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception('Failed to add event to favorite: ${response.body}');
      }
    } catch (e) {
      print("Error occurred while adding to favorite: $e");
      throw Exception("Failed to add event to favorite");
    }
  }

  Future<void> removeFromFavorite(
      {required String token, required String eventId}) async {
    try {
      final response = await http.delete(
        Uri.parse("$_baseUrl/api/events/$eventId/favorite"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("Remove Favorite Response status: ${response.statusCode}");

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to remove event from favorite: ${response.body}');
      }
    } catch (e) {
      print("Error occurred while removing event from favorite: $e");
      throw e;
    }
  }

  Future<List<Map<String, dynamic>>> fetchFavoriteEvents(
      {required String token}) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/api/events/favorite"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("Response status: ${response.statusCode}");
      print("Raw Response body: ${response.body}");

      if (response.statusCode == 200) {
        // Giải mã UTF-8
        final decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as List;
        print("Decoded Response body: $decodedResponse");

        return List<Map<String, dynamic>>.from(decodedResponse);
      } else {
        throw Exception('Failed to fetch favorite events: ${response.body}');
      }
    } catch (e) {
      print("Error occurred while fetching favorite events: $e");
      return [];
    }
  }
}
