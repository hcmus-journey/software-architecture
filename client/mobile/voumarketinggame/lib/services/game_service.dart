import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:voumarketinggame/models/quiz_model.dart';

class ApiServiceGame {
  static const String _baseUrl = "http://localhost:8080";

  /// Start a quiz game
  Future<List<Quiz>> startQuizGame({
    required String eventId,
    required String authorizationToken,
  }) async {
    final url = Uri.parse('$_baseUrl/api/quiz-games/start?eventId=$eventId');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authorizationToken',
        },
      );

      // In ra kết quả trả về từ API (Response body)
      //print('Response status: ${response.statusCode}');

      // Kiểm tra và ép lại encoding nếu cần
      String responseBody = utf8.decode(response.bodyBytes);
      //print('Response body: $responseBody');

      if (response.statusCode == 200) {
        // Decode response and convert it to a list of Quiz objects
        final List<dynamic> data = json.decode(responseBody);
        return data.map((quizJson) => Quiz.fromJson(quizJson)).toList();
      } else {
        // In thêm thông báo lỗi chi tiết
        final errorData = json.decode(responseBody);
        throw Exception(
          'Failed to start quiz game: ${response.statusCode} - ${errorData['message'] ?? 'Unknown error'}',
        );
      }
    } catch (error) {
      throw Exception('Error starting quiz game: $error');
    }
  }

  /// Start a shake game
  Future<bool> startShakeGame({
    required String eventId,
    required String authorizationToken,
  }) async {
    final url = Uri.parse('$_baseUrl/api/shake-games/start?eventId=$eventId');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authorizationToken',
        },
      );

      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        // Kiểm tra kết quả trả về
        return responseBody['isDrop'] ?? false;
      } else {
        // Xử lý lỗi nếu mã trạng thái không phải 200
        throw Exception(
          'Failed to start shake game: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (error) {
      throw Exception('Error starting shake game: $error');
    }
  }

  /// End a quiz game
  Future<Map<String, dynamic>> endQuizGame({
    required String eventId,
    required int questionCount,
    required int correctAnswerCount,
    required String authorizationToken,
  }) async {
    final url = Uri.parse('$_baseUrl/api/quiz-games/end');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authorizationToken',
        },
        body: json.encode({
          'eventId': eventId,
          'questionCount': questionCount,
          'correctAnswerCount': correctAnswerCount,
        }),
      );

      // Debug thông tin trả về từ API
      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Parse response body thành JSON
        final Map<String, dynamic> data = json.decode(response.body);

        // Trả về thông tin voucher hoặc kết quả
        return data;
      } else {
        // Xử lý lỗi nếu trạng thái không phải 200
        final errorData = json.decode(response.body);
        throw Exception(
          'Failed to end quiz game: ${response.statusCode} - ${errorData['message'] ?? 'Unknown error'}',
        );
      }
    } catch (error) {
      throw Exception('Error ending quiz game: $error');
    }
  }
}
