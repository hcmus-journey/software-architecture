import 'package:flutter/material.dart';

class FieldContainer extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  final VoidCallback? onEdit;

  const FieldContainer({
    super.key,
    required this.icon,
    required this.label,
    required this.controller,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(icon, size: 28, color: Colors.black),
          const SizedBox(width: 10),
          Expanded(
            child: Focus(
              onFocusChange: (hasFocus) {},
              child: TextField(
                controller: controller,
                readOnly: onEdit != null,
                onTap: onEdit,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  enabledBorder: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
