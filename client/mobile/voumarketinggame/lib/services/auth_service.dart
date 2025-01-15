import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceAuthentication {
  static const String _baseUrl = "http://localhost:8080";

  Future<Map<String, dynamic>> signUp({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/api/auth/sign-up');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
          'role': 'PLAYER',
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'error': 'Failed to sign up',
          'statusCode': response.statusCode,
          'message': json.decode(response.body)['message'] ?? 'Unknown error',
        };
      }
    } catch (error) {
      return {
        'error': 'An error occurred',
        'message': error.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> login(
      {required String username, required String password}) async {
    final url = Uri.parse('$_baseUrl/api/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          "accessToken": data["accessToken"],
          "refreshToken": data["refreshToken"],
        };
      } else {
        throw Exception(
            "Failed to login: ${json.decode(response.body)['message'] ?? 'Unknown error'}");
      }
    } catch (e) {
      throw Exception("Error during login: $e");
    }
  }
}
