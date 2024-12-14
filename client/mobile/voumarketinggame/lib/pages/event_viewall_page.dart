import 'package:flutter/material.dart';
import 'package:voumarketinggame/pages/event_detail_page.dart';
import 'package:voumarketinggame/widgets/item_list_widget.dart';

class EventViewallScreen extends StatelessWidget {
  final List<Map<String, String>> events;
  final String eventType; 

  const EventViewallScreen({
    super.key,
    required this.events,
    required this.eventType,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            
            Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                color: Colors.pinkAccent,
    
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 5, 
                    offset: const Offset(0, 3), 
                  ),
                ],
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 2, 
                ),
              ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    eventType,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ),
            
      
            const SizedBox(height: 5),
      
            // Event ListView
            if (events.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'Không có sự kiện nào!',
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
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return EventItem(
                      event: event,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetailScreen(
                              event: event,
                              eventType: eventType,
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
      ),
    );
  }
}
