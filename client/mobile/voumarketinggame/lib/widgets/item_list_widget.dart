import 'package:flutter/material.dart';
import 'package:voumarketinggame/models/events_model.dart';

class EventItem extends StatelessWidget {
  final EventModel event;
  final VoidCallback onTap;

  const EventItem({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade400, width: 1), 
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [ 
              Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 150, 
                        maxHeight: 120,
                      ),
                      child: Image.network(
                        event.imageUrl, 
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child; 
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ?? 1)
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
                  ),
                const SizedBox(width: 12),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        event.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'HSD: ${event.endTime}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 13),
                    ],
                  ),
                ),
              ],
            ),
            Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(event.brandImageUrl),
                    radius: 10,
                    child: const Icon(Icons.error, size: 10), 
                  ),


                  const SizedBox(width: 5),
                  Text(
                    event.brandName,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Spacer(),
                  Align(
                  alignment: Alignment.bottomRight,
                  child: OutlinedButton(
                    onPressed: onTap,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.pink),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    child: const Text(
                      'Chi tiết',
                      style: TextStyle(color: Colors.pink, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }
}
