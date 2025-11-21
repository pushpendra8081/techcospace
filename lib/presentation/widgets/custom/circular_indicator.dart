import 'package:flutter/material.dart';
import '../../../core/utils/constants.dart';

class CircularMetricIndicator extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final Color color;
  const CircularMetricIndicator({super.key, required this.value, required this.min, required this.max, required this.color});

  @override
  Widget build(BuildContext context) {
    final pct = ((value - min) / (max - min)).clamp(0.0, 1.0);
    return SizedBox(
      height: 80,
      width: 80,
      child: CustomPaint(
        painter: _CircularPainter(pct: pct, color: color),
        child: Center(
          child: Text('${(pct * 100).round()}%', style: Theme.of(context).textTheme.titleMedium),
        ),
      ),
    );
  }
}

class _CircularPainter extends CustomPainter {
  final double pct;
  final Color color;
  _CircularPainter({required this.pct, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    final basePaint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    final arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;
    canvas.drawCircle(center, radius, basePaint);
    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweep = pct * 6.283185307179586;
    canvas.drawArc(rect, -1.5708, sweep, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant _CircularPainter oldDelegate) {
    return oldDelegate.pct != pct || oldDelegate.color != color;
  }
}