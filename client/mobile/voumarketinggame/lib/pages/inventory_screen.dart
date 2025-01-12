import 'package:flutter/material.dart';
import 'package:voumarketinggame/widgets/inventory_button.dart';

class InventoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> inventoryItems = [
    {
      'title': 'Quiz Challenge 1',
      'currentCoins': 0,
      'image': 'assets/images/quiz_banner.png',
    },
    {
      'title': 'Quiz Challenge 2',
      'currentCoins': 1000,
      'image': 'assets/images/quiz_banner.png',
    },
    {
      'title': 'Quiz Challenge 3',
      'currentCoins': 15,
      'image': 'assets/images/quiz_banner.png',
    },
  ];

  InventoryPage({super.key});

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
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: inventoryItems.length,
        itemBuilder: (context, index) {
          final item = inventoryItems[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: InventoryButton(
              title: item['title'],
              currentCoins: item['currentCoins'],
              image: item['image'],
              onTap: () {
                // Xử lý logic khi nhấn InventoryButton
              },
            ),
          );
        },
      ),
    );
  }
}
