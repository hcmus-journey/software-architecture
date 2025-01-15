import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voumarketinggame/providers/auth_provider.dart';
import 'package:voumarketinggame/services/inventory_service.dart';

class InventoryButton extends StatefulWidget {
  final String title;
  final int currentCoins;
  final int requiredCoins;
  final String image;
  final String inventoryId;
  final String eventId;
  final VoidCallback onTap;

  const InventoryButton({
    super.key,
    required this.title,
    required this.currentCoins,
    required this.requiredCoins,
    required this.image,
    required this.inventoryId,
    required this.eventId,
    required this.onTap,
  });

  @override
  State<InventoryButton> createState() => _InventoryButtonState();
}

class _InventoryButtonState extends State<InventoryButton> {
  String selectedOption = 'Email';
  TextEditingController inputController = TextEditingController();

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Choose an action',
            style: TextStyle(color: Colors.pink),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.pinkAccent, width: 2),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: widget.currentCoins >= widget.requiredCoins
                      ? () async {
                          try {
                            final apiService = InventoryService();
                            final result = await apiService.exchangeCoin(
                                widget.inventoryId,
                                (await AuthProvider().getAccessToken())!);

                            // Kiểm tra xem result có chứa các khóa cần thiết hay không
                            final discount = result['discount'] ??
                                0; // Nếu không có discount thì lấy giá trị mặc định là 0
                            final code = result['code'] ??
                                'INVALID CODE'; // Nếu không có code thì lấy giá trị mặc định là 'INVALID CODE'
                            // ignore: use_build_context_synchronously
                            _showVoucherDialog(context, discount, code);
                            widget.onTap();
                          } catch (error) {
                            //print('Error redeem coin: $error');
                          }
                        }
                      : () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Not enough coins!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                  child: const Text('Redeem Voucher'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.pinkAccent, width: 2),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: widget.currentCoins > 0
                      ? () {
                          Navigator.pop(context);
                          _showGiftDialog(context);
                        }
                      : () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Not enough coins!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                  child: const Text('Gift Coins'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showVoucherDialog(BuildContext context, int discount, String code) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Voucher Code',
            style: TextStyle(color: Colors.pink),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Your voucher code is: ',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.grey.shade200,
                      child: Text(
                        code, // Hiển thị code từ API trả về
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.pinkAccent),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                          text: code)); // Sao chép code vào clipboard
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Copied to clipboard'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Discount: $discount%', // Hiển thị discount
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showGiftDialog(BuildContext context) {
    int selectedCoins = 1;
    TextEditingController coinController =
        TextEditingController(text: selectedCoins.toString());

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Gift Coins',
                style: TextStyle(color: Colors.pink),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton<String>(
                        value: selectedOption,
                        items: const [
                          DropdownMenuItem(
                            value: 'Email',
                            child: Text('To Email',
                                style: TextStyle(color: Colors.pink)),
                          ),
                          DropdownMenuItem(
                            value: 'UserID',
                            child: Text('To UserID',
                                style: TextStyle(color: Colors.pink)),
                          ),
                          DropdownMenuItem(
                            value: 'Phone',
                            child: Text('To Phone',
                                style: TextStyle(color: Colors.pink)),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value ?? 'Email';
                            inputController.text = '';
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: inputController,
                      decoration: InputDecoration(
                        hintText: 'Enter $selectedOption',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Select Coins: ',
                          style: TextStyle(color: Colors.pink),
                        ),
                        Expanded(
                          child: Slider(
                            value: selectedCoins.toDouble(),
                            min: 1,
                            max: widget.currentCoins.toDouble(),
                            divisions: widget.currentCoins,
                            label: selectedCoins.toString(),
                            onChanged: (value) {
                              setState(() {
                                selectedCoins = value.toInt();
                                coinController.text = selectedCoins.toString();
                              });
                            },
                            activeColor: Colors.pink,
                            inactiveColor: Colors.pink.withOpacity(0.3),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          child: TextField(
                            controller: coinController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                selectedCoins = int.tryParse(value) ?? 1;
                                if (selectedCoins < 1) {
                                  selectedCoins = 1;
                                }
                                if (selectedCoins > widget.currentCoins) {
                                  selectedCoins = widget.currentCoins;
                                }
                                coinController.text = selectedCoins.toString();
                                coinController.selection =
                                    TextSelection.collapsed(
                                        offset: coinController.text.length);
                              });
                            },
                            decoration: InputDecoration(
                              hintText: selectedCoins.toString(),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Đóng dialog khi nhấn Cancel
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.pink,
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.pinkAccent),
                        minimumSize: const Size(100, 36),
                      ),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final apiService = InventoryService();
                          await apiService.giftCoin(
                            widget.inventoryId,
                            (await AuthProvider().getAccessToken())!,
                            widget.eventId,
                            selectedCoins,
                            inputController.text,
                          );
                          widget.onTap();
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context); // Đóng dialog

                          // Hiển thị SnackBar thông báo thành công
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Gift coin thành công!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } catch (error) {
                          //print('Error gift coin: $error');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.pink,
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.pinkAccent),
                        minimumSize: const Size(100, 36),
                      ),
                      child: const Text('Gift'),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDialog(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.currentCoins}/${widget.requiredCoins}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.image, // Đây là URL của ảnh
                width: 100,
                height: 100,
                fit: BoxFit.cover,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
