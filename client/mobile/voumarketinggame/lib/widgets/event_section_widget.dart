import 'package:flutter/material.dart';
import 'package:voumarketinggame/models/events_model.dart';
import 'package:voumarketinggame/widgets/listview_widget.dart';

class EventSection extends StatelessWidget {
  final String time;
  final List<EventModel> items;
  final VoidCallback onViewAll;
  final Function(Map<String, String>) onItemTap; 

  const EventSection({
    super.key,
    required this.time,
    required this.items,
    required this.onViewAll,
    required this.onItemTap, 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 18,
                  
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: onViewAll,
                child: const Text(
                  'Xem tất cả',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        HorizontalList(
          time: time,
          items: items,
          onItemTap: onItemTap,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
