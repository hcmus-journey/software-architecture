import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voumarketinggame/models/events_model.dart';
import 'package:voumarketinggame/models/vouchers_model.dart';

class VoucherItem extends StatelessWidget {
  final VoucherModel voucher;
  final EventModel? event;
  final VoidCallback onTap;

  const VoucherItem({
    super.key,
    required this.voucher,
    required this.event,
    required this.onTap,
  });

  
  @override
  Widget build(BuildContext context) {
    
    // Định dạng ngày thành YYYY-MM-DD
    final String formattedReceivedAt =
        DateFormat('yyyy-MM-dd').format(voucher.receivedAt);
    final String formattedExpiredAt =
        DateFormat('yyyy-MM-dd').format(voucher.expiredAt);
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
                child: Image.network(
                  event?.imageUrl ?? 'assets/images/logo.png',
                  width: 90,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),

                const SizedBox(width: 12),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Voucher: Discount ${voucher.discount} %',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        event?.description ?? "Not description",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Received: $formattedReceivedAt',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'HSD: $formattedExpiredAt',
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
                    backgroundImage: event?.brandImageUrl != null
                        ? NetworkImage(event!.brandImageUrl)
                        : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                    radius: 10,
                  ),

                  const SizedBox(width: 5),
                  Text(
                    event?.brandName ?? 'Brand not available',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Spacer(),
                  Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink, 
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 6, 
                      shadowColor: Colors.pink.withOpacity(0.5), 
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), 
                    ),
                    child: const Text(
                      'Sử dụng ngay',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
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
