import 'dart:convert';
import 'package:http/http.dart' as http;

class InventoryService {
  final String baseUrl;

  //InventoryService({this.baseUrl = 'http://localhost:8080'});
  InventoryService({this.baseUrl = 'http://10.0.2.2:8080'});

  // Fetch inventories
  Future<List<Map<String, dynamic>>> fetchInventories(String authToken) async {
    final url = Uri.parse('$baseUrl/api/inventories');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        final List<dynamic> jsonData = json.decode(responseBody);
        return jsonData.cast<Map<String, dynamic>>();
      } else {
        throw Exception(
            'Failed to fetch inventories. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching inventories: $error');
    }
  }

  // Gọi API gift coin
  Future<void> giftCoin(
    String inventoryId,
    String authToken,
    String eventId,
    int coins,
    String receiverId,
  ) async {
    final url = Uri.parse('$baseUrl/api/inventories/$inventoryId/gift-coin');

    // Chuẩn bị body request
    final Map<String, dynamic> giftDetails = {
      "eventId": eventId,
      "coins": coins,
      "receiverId": receiverId,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(giftDetails),
      );

      if (response.statusCode == 200) {
        //print("Gift coin successful");
      } else {
        throw Exception(
            'Failed to gift coin. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error gifting coin: $error');
    }
  }

  // Exchange coin for voucher
  Future<Map<String, dynamic>> exchangeCoin(
      String inventoryId, String authToken) async {
    final url =
        Uri.parse('$baseUrl/api/inventories/$inventoryId/exchange-coin');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        //print("Exchange coin successful");
        final Map<String, dynamic> data = json.decode(response.body);

        // Trả về thông tin voucher hoặc kết quả
        return data;
      } else {
        throw Exception(
            'Failed to exchange coin for voucher. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error exchanging coin: $error');
    }
  }
}
