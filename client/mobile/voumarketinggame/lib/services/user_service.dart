import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String _baseUrl = "http://10.0.2.2:8080";

  Future<Map<String, dynamic>> updateUser({
    required String token,
    required Map<String, dynamic> userInfo,
  }) async {
    final url = Uri.parse('$_baseUrl/api/player/active');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(userInfo),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'error': 'Failed to update user',
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
}
