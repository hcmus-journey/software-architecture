import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voumarketinggame/providers/event_provider.dart';

class VoucherItem extends StatelessWidget {
  final Map<String, dynamic> voucher;
  final VoidCallback onTap;

  const VoucherItem({
    super.key,
    required this.voucher,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final allEvents = Provider.of<EventProvider>(context, listen: false).AllEvents;
    final event = allEvents.firstWhere(
      (event) => event['id'] == voucher['eventID'],
      orElse: () => {'detail': 'Thông tin không khả dụng', 'store': ''},
    );
    
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
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Image.asset(
                        voucher['image']!,
                        width: 90,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discount: ${voucher['discount']!}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        voucher['detail']!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Received: ${voucher['received_at']}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 13),
                      Text(
                        'HSD: ${voucher['date_exp']}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(event['avatar']!),
                    radius: 10,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    event['store']!,
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
