import 'package:flutter/material.dart';
import 'package:voumarketinggame/models/events_model.dart';
import 'package:voumarketinggame/pages/event_detail_page.dart';

class HorizontalList extends StatelessWidget {
  final String time;
  final List<EventModel> items;
  final Function(EventModel) onItemTap;

  const HorizontalList({
    super.key,
    required this.time,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final int used = item.redeemedVouchers;
          final int count = item.totalVouchers;
          final double progress = (used / count).clamp(0.0, 1.0);
          
          
          return GestureDetector(
            onTap: () {
              onItemTap(item);
            },
            child: Container(
              width: 200,
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: Image.network(
                      item.imageUrl,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          ); 
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, size: 50);
                      },
                    ),
                  ),

                  const SizedBox(height: 8),
                  // Store Info
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(item.brandImageUrl), 
                          radius: 10,
                          onBackgroundImageError: (error, stackTrace) {
                            print('Failed to load brand image: $error');
                          },
                        ),


                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.brandName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Event Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Event Details
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  // Progress Bar + Collect Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.local_fire_department, color: Colors.orange, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Đã nhận ${(progress * 100).toStringAsFixed(0)}%',
                                    style: const TextStyle(fontSize: 12, color: Colors.orange),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  backgroundColor: Colors.grey.shade300,
                                  color: Colors.orange,
                                  minHeight: 6,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (e) => EventDetailScreen(
                                  event: item,
                                  eventType: time,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: const BorderSide(color: Colors.pinkAccent),
                          ),
                          child: const Text(
                            'Chi tiết',
                            style: TextStyle(fontSize: 13, color: Colors.pinkAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
