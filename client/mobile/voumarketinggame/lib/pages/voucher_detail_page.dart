import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voumarketinggame/providers/event_provider.dart';
import 'package:voumarketinggame/widgets/guide_widget.dart';
import 'package:voumarketinggame/widgets/item_voucher_widget.dart';

class VoucherDetailScreen extends StatelessWidget {
  final Map<String, dynamic> voucher;
  final String type;

  const VoucherDetailScreen({
    super.key,
    required this.voucher,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {

    final eventProvider = Provider.of<EventProviderData>(context);
    final event = eventProvider.AllEvents.firstWhere(
      (event) => event['id'] == voucher['eventID'],
      orElse: () => {'detail': 'Thông tin không khả dụng', 'store': ''},
    );
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
                    type,
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

                  //const SizedBox(height: 16.0),

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
                            "Hạn sử dụng tới ${voucher['date_exp']}",
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
      
                  const SizedBox(height: 12), 
                  // Item Voucher
                  VoucherCard(voucher: voucher),

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
                          'Điều khoản sử dụng:',
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
                        const SizedBox(height: 5),
                        const Text(
                          '• Voucher áp dụng tại cửa hàng/online.',
                          style: TextStyle(fontSize: 16),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          '• Khung giờ áp dụng: Tất cả khung giờ.',
                          style: TextStyle(fontSize: 16),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          '• Áp dụng cho hóa đơn từ 0đ.',
                          style: TextStyle(fontSize: 16),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                            title: 'Hướng dẫn sử dụng voucher',
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
                                'Hướng dẫn sử dụng voucher',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                        ],
                      ),
                    ),
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
                  'Sử dụng',
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
