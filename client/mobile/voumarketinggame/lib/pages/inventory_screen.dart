import 'package:flutter/material.dart';
import 'package:voumarketinggame/widgets/inventory_button.dart';
import 'package:voumarketinggame/services/inventory_service.dart';
import 'package:voumarketinggame/providers/auth_provider.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final InventoryService inventoryService = InventoryService();
  List<Map<String, dynamic>> inventoryItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchInventories();
  }

  Future<void> _fetchInventories() async {
    try {
      var authToken = (await AuthProvider().getAccessToken())!;
      final inventories = await inventoryService.fetchInventories(authToken);

      setState(() {
        inventoryItems = inventories.map((item) {
          return {
            'title': item['eventName'],
            'currentCoins': item['collectedCoins'],
            'requiredCoins': item['requiredCoins'],
            'image': item['eventImageUrl'],
            'inventoryId': item['inventoryId'],
            'eventId': item['eventId'],
          };
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading inventory: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Inventory',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.pinkAccent))
          : inventoryItems.isEmpty
              ? const Center(
                  child: Text(
                    'No inventory items available',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: inventoryItems.length,
                  itemBuilder: (context, index) {
                    final item = inventoryItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: InventoryButton(
                        title: item['title'],
                        currentCoins: item['currentCoins'],
                        requiredCoins: item['requiredCoins'],
                        image: item['image'],
                        inventoryId: item['inventoryId'],
                        eventId: item['eventId'],
                        onTap: () {
                          _fetchInventories();
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
