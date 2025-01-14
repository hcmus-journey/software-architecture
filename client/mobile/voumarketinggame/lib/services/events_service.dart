import 'dart:convert';
import 'package:http/http.dart' as http;

class EventService {

  static const String _baseUrl = "http://10.0.2.2:8080";

  Future<List<Map<String, dynamic>>> getAllEvents({required String token}) async {
  try {
    final response = await http.get(
      Uri.parse("$_baseUrl/api/events"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body) as List;
      return List<Map<String, dynamic>>.from(decodedResponse);
    } else {
      throw Exception('Failed to fetch events: ${response.body}');
    }
  } catch (e) {
    print("Error occurred while fetching events: $e");
    return [];
  }
}




}