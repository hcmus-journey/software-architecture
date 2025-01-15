import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  //static const String _baseUrl = "http://localhost:8080";
  static const String _baseUrl = "http://10.0.2.2:8080";

  Future<Map<String, dynamic>> updateUserActive({
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

  Future<Map<String, dynamic>> getUserProfile({
    required String token,
  }) async {
    final url = Uri.parse('$_baseUrl/api/player/profile');

    print("[getUserProfile] Requesting profile with token: $token");
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("[getUserProfile] Response status: ${response.statusCode}");
      print("[getUserProfile] Response body: ${response.body}");

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        print("[getUserProfile] Decoded body: $decodedBody");
        return decodedBody;
      } else {
        final errorBody = json.decode(response.body);
        print("[getUserProfile] Error response body: $errorBody");
        return {
          'error': 'Failed to fetch user profile',
          'statusCode': response.statusCode,
          'message': errorBody['message'] ?? 'Unknown error',
        };
      }
    } catch (error) {
      print("[getUserProfile] Exception: $error");
      return {
        'error': 'An error occurred',
        'message': error.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> updateUser({
    required String token,
    required Map<String, dynamic> userInfo,
  }) async {
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/api/player/profile"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userInfo),
      );

      print("Request body: ${jsonEncode(userInfo)}");
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        print("Decoded response: $decodedResponse");
        return decodedResponse;
      } else {
        final errorResponse = {
          'error': true,
          'message': jsonDecode(response.body)['message'] ?? 'Update failed',
        };
        print("Error response: $errorResponse");
        return errorResponse;
      }
    } catch (e) {
      print("Exception occurred: $e");
      return {'error': true, 'message': e.toString()};
    }
  }
}
