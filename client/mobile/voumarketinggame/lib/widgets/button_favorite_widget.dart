import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final String eventId;
  final bool isFavorite;
  final Function(bool) onToggleFavorite;

  const FavoriteButton({
    super.key,
    required this.eventId,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() async {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    try {
      widget.onToggleFavorite(_isFavorite);
    } catch (e) {
      // Khôi phục trạng thái cũ nếu có lỗi
      setState(() {
        _isFavorite = !_isFavorite;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _toggleFavorite,
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
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: _isFavorite ? Colors.red : Colors.black,
        size: 20,
      ),
      label: Text(
        _isFavorite ? 'Unsave' : 'Save',
        style: TextStyle(
          fontSize: 16,
          color: _isFavorite ? Colors.red : Colors.black,
        ),
      ),
    );
  }
}
