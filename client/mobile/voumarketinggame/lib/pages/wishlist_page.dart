import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voumarketinggame/pages/event_detail_page.dart';
import 'package:voumarketinggame/providers/events_provider.dart';
import 'package:voumarketinggame/widgets/filter_button_widget.dart';
import 'package:voumarketinggame/widgets/item_list_widget.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _fetchFavoriteEvents());
  }

  Future<void> _fetchFavoriteEvents() async {
    
    try {
      
      final eventProvider = Provider.of<EventProvider>(context, listen: false);
      await eventProvider.fetchFavoriteEvents(context);
    } catch (e) {
      print('Error fetching events: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final wishlistEvent = Provider.of<EventProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Filter Buttons
          SingleChildScrollView(
          child: Container(
          padding: const EdgeInsets.all(8), 
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1, 
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Search Bar
              Container(
                width: 255, 
                height: 40, 
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20), 
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm sự kiện',
                    hintStyle: TextStyle(color: Colors.grey), 
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none, 
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
          
              FilterButton(
                label: 'Bộ lọc',
                icon: Icons.filter_alt,
                onPressed: () {
                  showFilterModal(context);
                },
              ),
            ],
            ),
          ) 
        ),

        const SizedBox(height: 5),

        // Wishlist ListView
        if (wishlistEvent.favorites.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                'Danh sách yêu thích trống!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: wishlistEvent.favorites.length,
              itemBuilder: (context, index) {
                final event = wishlistEvent.favorites[index];
                return EventItem(
                  event: event,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailScreen(
                          event: event,
                          eventType: 'Sự kiện yêu thích',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  } 
}
