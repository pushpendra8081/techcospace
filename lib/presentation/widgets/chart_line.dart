import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MetricLineChart extends StatelessWidget {
  final List<double> points;
  final Color color;
  final double height;
  const MetricLineChart({super.key, required this.points, required this.color, this.height = 160});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true, drawVerticalLine: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: color,
              barWidth: 3,
              dotData: FlDotData(show: false),
              spots: [
                for (int i = 0; i < points.length; i++) FlSpot(i.toDouble(), points[i])
              ],
              belowBarData: BarAreaData(show: true, color: color.withOpacity(0.15)),
            ),
          ],
        ),
      ),
    );
  }
}