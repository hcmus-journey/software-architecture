import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BottomNavStatistics extends StatelessWidget {
  final Map<String, double> stats; // Thống kê các câu trả lời

  const BottomNavStatistics({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    stats.values.reduce((a, b) => a + b);

    return Container(
      constraints: BoxConstraints(
        maxHeight:
            MediaQuery.of(context).size.height * 0.6, // Giới hạn chiều cao
      ),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        // Giải quyết overflow
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "ĐÁP ÁN",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 180, // Giới hạn chiều cao biểu đồ
              child: BarChart(
                BarChartData(
                  barGroups: stats.keys.map((option) {
                    final value = stats[option]!;
                    return BarChartGroupData(
                      x: option.codeUnitAt(0), // Mã ASCII cho A, B, C, D
                      barRods: [
                        BarChartRodData(
                          toY: value,
                          color: option == 'A'
                              ? Colors.pinkAccent
                              : Colors.grey, // Đúng thì cột màu đỏ
                          width: 20,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          final option = String.fromCharCode(value.toInt());
                          return Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Text(
                              option,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
