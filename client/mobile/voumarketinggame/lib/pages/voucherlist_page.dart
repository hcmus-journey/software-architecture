import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voumarketinggame/pages/voucher_detail_page.dart';
import 'package:voumarketinggame/providers/events_provider.dart';
import 'package:voumarketinggame/providers/vouchers_provider.dart';
import 'package:voumarketinggame/widgets/filter_button_widget.dart';
import 'package:voumarketinggame/widgets/voucher_list_widget.dart';

class VoucherlistScreen extends StatefulWidget {
  const VoucherlistScreen({super.key});

  @override
  State<VoucherlistScreen> createState() => _VoucherlistScreenState();
}

class _VoucherlistScreenState extends State<VoucherlistScreen> {

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _fetchFavoriteEvents());
  }

  Future<void> _fetchFavoriteEvents() async {
    
    try {
      final eventProvider = Provider.of<VoucherProvider>(context, listen: false);
      await eventProvider.fetchVouchers(context);
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
    final voucherList = Provider.of<VoucherProvider>(context);

    
    
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
                    hintText: 'Tìm kiếm voucher',
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

        if (voucherList.vouchers.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                'Danh sách voucher trống!',
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
              itemCount: voucherList.vouchers.length,
              itemBuilder: (context, index) {
                final voucher = voucherList.vouchers[index];
                final eventProvider = Provider.of<EventProvider>(context, listen: false);
                final event = eventProvider.getEventById(voucher.eventId);
                return VoucherItem(
                  voucher: voucher,
                  event: event,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VoucherDetailScreen(
                          voucher: voucher,
                          event: event,
                          type: 'Chi tiết Voucher',
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
