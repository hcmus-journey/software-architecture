import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voumarketinggame/models/vouchers_model.dart';

class VoucherCard extends StatelessWidget {
  final VoucherModel voucher;

  const VoucherCard({
    super.key,
    required this.voucher,
  });

  @override
  Widget build(BuildContext context) {

    final String formattedExpiredAt =
        DateFormat('yyyy-MM-dd').format(voucher.expiredAt);
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 4), 
                blurRadius: 10,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Nền và nội dung voucher
              CustomPaint(
                painter: VoucherBackgroundPainter(),
                child: const SizedBox(
                  width: 350,
                  height: 180,
                ),
              ),
              // Nội dung voucher
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
               
                      const SizedBox(width: 5),
                      const Expanded(
                        flex: 1,
                        child: Center(
                          child: RotatedBox(
                            quarterTurns: 3, 
                            child: Text(
                              "COUPON",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Divider giữa hai phần
                      CustomPaint(
                        size: const Size(1, double.infinity),
                        painter: DottedLinePainter(),
                      ),
                     
                      const SizedBox(width: 30),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              "Discount ${voucher.discount} %",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Code: ${voucher.code}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Exp: $formattedExpiredAt",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 22),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 120,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white, 
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/mavach2.png',
                                    fit: BoxFit.contain, 
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VoucherBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red.shade800;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);

    final circlePaint = Paint()..color = Colors.white;
    const double radius = 6.2;

    for (double y = radius; y < size.height; y += 2 * radius + 8.5) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(0, y), radius: radius),
        -3.14 / 2, 
        3.14, 
        false,
        circlePaint,
      );
    }

    for (double y = radius; y < size.height; y += 2 * radius + 8.5) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(size.width, y), radius: radius),
        3.14 / 2,
        3.14,
        false,
        circlePaint,
      );
    }

    const double holeRadius = 15.0;
    final holeXPosition = size.width / 4;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(holeXPosition, 0), radius: holeRadius),
      0, 
      3.14,
      false, 
      circlePaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: Offset(holeXPosition, size.height), radius: holeRadius),
      3.14, 
      3.14, 
      false, 
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    const double dashHeight = 5;
    const double dashSpace = 7;
    double startY = 8;

    const double offsetX = 4; 
    while (startY < size.height) {
      canvas.drawLine(
        Offset(offsetX, startY), 
        Offset(offsetX, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
