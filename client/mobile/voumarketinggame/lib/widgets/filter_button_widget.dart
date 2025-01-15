import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;

  const FilterButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon, size: 16) : const SizedBox.shrink(),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.pink,
          side: const BorderSide(color: Colors.pink),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

void showFilterModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isScrollControlled: true, 
    builder: (context) {
      return const FilterModal();
    },
  );
}

class FilterModal extends StatelessWidget {
  const FilterModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100, 
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16), 
        ),
      ),
      child: DraggableScrollableSheet(
        expand: false, 
        initialChildSize: 0.85,
        minChildSize: 0.5, 
        maxChildSize: 0.85, 
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController, 
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 40),
                      const Text(
                        'Bộ lọc',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: Colors.black),
                      ),
                    ],
                  ),
      
                  const Divider(),
               
                  _buildSection(
                    title: 'Sắp xếp theo',
                      children: [
                        _buildRadioButton(context, 'Mới nhất', 0),
                        _buildRadioButton(context, 'Sắp hết hạn', 1),
                      ],
                  ),
                  
                  const SizedBox(height: 16),
                  // Choose preference
                  _buildSection(
                    title: 'Tùy chọn ưu đãi',
                      children: [
                        _buildCheckbox(context, 'Gần tôi'),
                        _buildCheckbox(context, 'Sắp hết voucher'),
                      ],
                  ),
                  
                  const SizedBox(height: 16),
                  // Service filter
                  _buildSection(
                  title: 'Dịch vụ',
                  children: [
                    _buildCheckbox(context, 'Chuyển/nhận tiền'),
                    _buildCheckbox(context, 'Thanh toán hóa đơn'),
                    _buildCheckbox(context, 'Tiện ích mỗi ngày'),
                    _buildCheckbox(context, 'Dịch vụ tài chính'),
                    _buildCheckbox(context, 'Du lịch - Đi lại'),
                    _buildCheckbox(context, 'Giải trí'),
                    _buildCheckbox(context, 'Dịch vụ ăn uống'),
                    _buildCheckbox(context, 'Dịch vụ khác'),
                  ],
                ),
                  const SizedBox(height: 16),
                  // Apply button
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                          ),
                          child: const Text('Xóa bộ lọc'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          padding: const EdgeInsets.symmetric(vertical: 12), 
                          minimumSize: const Size(0, 40), 
                        ),
                        child: const Text('Áp dụng'),
                      ),
                    ),
      
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRadioButton(BuildContext context, String label, int value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<int>(
          value: value,
          groupValue: 0,
          onChanged: (val) {},
          activeColor: Colors.pink,
        ),
        Text(label),
      ],
    );
  }

  Widget _buildCheckbox(BuildContext context, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Checkbox(
        value: false,
        onChanged: (val) {},
        activeColor: Colors.pink,
      ),
      Expanded(child: Text(label)), 
    ],
  );
}


  Widget _buildSection({required String title, required List<Widget> children}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0.5), 
    child: Container(
      width: double.infinity, 
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),

          // Child elements in two columns
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), 
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 12, 
              mainAxisSpacing: 10,
              childAspectRatio: 3.5, 
            ),
            itemCount: children.length,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.centerLeft, 
                child: children[index],
              );
            },
          ),
        ],
      ),
    ),
  );
}




}
