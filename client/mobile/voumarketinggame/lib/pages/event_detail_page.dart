import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voumarketinggame/pages/event_viewall_page.dart';
import 'package:voumarketinggame/providers/event_provider.dart';
import 'package:voumarketinggame/widgets/event_section_widget.dart';
import 'package:voumarketinggame/widgets/guide_widget.dart';

class EventDetailScreen extends StatelessWidget {
  final Map<String, String> event;
  final String eventType;

  const EventDetailScreen({
    super.key,
    required this.event,
    required this.eventType,
  });

  @override
  Widget build(BuildContext context) {

    final eventProvider = Provider.of<EventProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Column(
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
                    eventType,
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
                    child: ClipRRect(
                      child: Image.asset(
                        event['image']!,
                        height: MediaQuery.of(context).size.height * 0.25,
                        fit: BoxFit.cover,
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
                            eventType,
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
                          event['title'] ?? '',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          event['detail'] ?? '',
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
                              backgroundImage: AssetImage(
                                  event['avatar'] ?? 'assets/bg2.png'),
                              radius: 17,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              event['store'] ?? '',
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
                          const Icon(Icons.timeline_outlined, color: Colors.black),
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
                          event['startDate'] ?? '',
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
                          event['endDate'] ?? '',
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
                          const Icon(Icons.card_giftcard, color: Colors.black),
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
                          '${int.parse(event['voucherCount'] ?? '0') - int.parse(event['voucherUsed'] ?? '0')}', 
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
                          event['voucherCount'] ?? '0',
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
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
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
                      const Text(
                        '• Áp dụng cho khách hàng mới và cũ.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text(
                        '• Đạt số điểm tối thiểu 80/120.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text(
                        '• Số lượt chơi tối đa 3 lần.',
                        style: TextStyle(fontSize: 16),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Text(
                        '• Số lượng voucher có hạn.',
                        style: TextStyle(fontSize: 16),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [ 
                          TextButton(
                          onPressed: () {
                            
                          },
                          child: const Text(
                            'Xem thêm',
                            style: TextStyle(color: Colors.pink),
                          ),
                        ),
                        ]
                      ),
                    ],
                  ),
                ),
  
                // Guide Section
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) {
                        return const GuideWidget(
                          images: [
                            'assets/images/toco.png',
                            'assets/images/fashion.png',
                            'assets/images/trasuadodo.png',
                          ],
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
                items: eventProvider.getEventsByStore(event['store'] ?? ''),
                
                onItemTap: (event) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailScreen(event: event, eventType: "Sự kiện cùng hãng",),
                    ),
                  );
                },
                onViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventViewallScreen(
                      events: eventProvider.getEventsByStore(event['store'] ?? ''),
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
      child: 
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã thêm vào danh sách yêu thích!'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
              backgroundColor: Colors.white,
              shadowColor: Colors.blue.withOpacity(0.5),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: const BorderSide(
                color: Colors.black38,
                width: 1,
              ),
            ),
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black,
              size: 20,
            ),
            label: const Text(
              'Save',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),

            
          const SizedBox(width: 8),

          Expanded(
            child: ElevatedButton(
              onPressed: () {
                
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
          ]
          ),
        ),
      ),
    );
  }
}
