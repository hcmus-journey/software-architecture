import 'dart:convert';
import 'package:http/http.dart' as http;

class VoucherService {
  static const String _baseUrl = "http://10.0.2.2:8080";

  Future<List<Map<String, dynamic>>> fetchVouchers({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/api/vouchers"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as List;
        return List<Map<String, dynamic>>.from(decodedResponse);
      } else {
        throw Exception('Failed to fetch vouchers: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching vouchers: $e');
    }
  }
}
