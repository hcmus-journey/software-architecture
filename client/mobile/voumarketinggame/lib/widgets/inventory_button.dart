import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InventoryButton extends StatefulWidget {
  final String title;
  final int currentCoins;
  final String image;
  final VoidCallback onTap;

  const InventoryButton({
    super.key,
    required this.title,
    required this.currentCoins,
    required this.image,
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
                  onPressed: widget.currentCoins >= 10
                      ? () {
                          setState(() {
                            widget.onTap();
                            Navigator.pop(context);
                            _showVoucherDialog(context);
                          });
                        }
                      : () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Not enough coin!'),
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
                              content: Text('Not enough coin!'),
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

  void _showVoucherDialog(BuildContext context) {
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
                      child: const Text(
                        'ABC12AAAAAAAAAAAAAAAAAAAA3',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.pinkAccent),
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(
                          text: 'ABC12AAAAAAAAAAAAAAAAAAAA3'));
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
                        Navigator.pop(context);
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
                      onPressed: () {
                        // Implement gift logic
                        Navigator.pop(context);
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
                    '${widget.currentCoins}/10',
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
              child: Image.asset(
                widget.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
