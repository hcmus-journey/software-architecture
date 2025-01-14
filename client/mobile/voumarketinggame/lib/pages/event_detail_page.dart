import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voumarketinggame/models/events_model.dart';
import 'package:voumarketinggame/pages/event_viewall_page.dart';
import 'package:voumarketinggame/providers/events_provider.dart';
import 'package:voumarketinggame/widgets/button_favorite_widget.dart';
import 'package:voumarketinggame/widgets/event_section_widget.dart';
import 'package:voumarketinggame/widgets/guide_widget.dart';
import 'package:voumarketinggame/pages/splash_screen.dart';

class EventDetailScreen extends StatefulWidget {
  final EventModel event;
  final String eventType;

  const EventDetailScreen({
    super.key,
    required this.event,
    required this.eventType,
  });

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {

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
    
    final eventProvider = Provider.of<EventProvider>(context);
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return SafeArea(
      
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: 
        
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.eventType,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: 
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                        child: Image.network(
                          widget.event.imageUrl,
                          height: 210,
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

                    ),
                    const SizedBox(height: 16.0),

                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.timelapse, color: Colors.black),
                              const SizedBox(width: 8),
                              Text(
                                widget.eventType,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Tinh dem voucher vao de nhung ma thay xau, de giong momo cho dep

                    // Title and Store Info
                    const SizedBox(height: 7),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            widget.event.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.event.description,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(widget.event.brandImageUrl), 
                                radius: 10,
                                onBackgroundImageError: (error, stackTrace) {
                                  print('Failed to load brand image: $error'); 
                                },
                              ),

                              const SizedBox(width: 8),
                              
                              Text(
                                widget.event.brandName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.timeline_outlined,
                                  color: Colors.black),
                              const SizedBox(width: 8),
                              const Text(
                                'Thời gian:  ',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.event.startTime,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                              ),
                              const Text(
                                '  -  ',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                widget.event.endTime,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.card_giftcard,
                                  color: Colors.black),
                              const SizedBox(width: 8),
                              const Text(
                                'Voucher còn lại: ',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${widget.event.totalVouchers - widget.event.redeemedVouchers}',
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                              ),
                              const Text(
                                ' / ',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${widget.event.totalVouchers}',
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nội dung thể lệ:',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (widget.event.games.isNotEmpty)
                            ...widget.event.games.map((game) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '• ${game.name}',
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    game.description,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              );
                            }).toList()
                          else
                            const Text(
                              'Không có trò chơi nào!',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                        ],
                      ),
                    ),


                    // Guide Section
                    GestureDetector(
                      onTap: () {
                        final gameImages = widget.event.games.map((game) => game.imageUrl).toList();
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) {
                            return GuideWidget(
                              images: gameImages,
                              title: 'Hướng dẫn chơi game',
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.help_outline, color: Colors.grey),
                                SizedBox(width: 8),
                                Text(
                                  'Hướng dẫn chơi game',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                          ],
                        ),
                      ),
                    ),


                    EventSection(
                      time: "Sự kiện cùng hãng",
                      items: eventProvider.getEventsByBrand(widget.event.brandId),
                      onItemTap: (event) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetailScreen(
                              event: event,
                              eventType: "Sự kiện cùng hãng",
                            ),
                          ),
                        );
                      },
                      onViewAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventViewallScreen(
                              events: eventProvider.getEventsByBrand(widget.event.brandId),
                              eventType: "Sự kiện cùng hãng",
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            
            FavoriteButton(
              eventId: widget.event.eventId,
              isFavorite: eventProvider.isEventFavorite(widget.event.eventId),
              onToggleFavorite: (isFavorite) async {
                final eventProvider = Provider.of<EventProvider>(context, listen: false);

                try {
                  if (isFavorite) {
                    // Thêm vào danh sách yêu thích
                    await eventProvider.addToFavorite(context, widget.event.eventId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đã thêm vào danh sách yêu thích!')),
                    );
                  } else {
                    // Xóa khỏi danh sách yêu thích
                    await eventProvider.removeFromFavorite(context, widget.event.eventId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đã xóa khỏi danh sách yêu thích!')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lỗi: ${e.toString()}')),
                  );
                }
              },
            ),

            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15.0),
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Tham gia ngay',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
