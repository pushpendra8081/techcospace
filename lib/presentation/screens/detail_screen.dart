import 'package:flutter/material.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/extensions.dart';
import '../../data/models/metric.dart';
import '../widgets/chart_line.dart';
import '../widgets/custom/circular_indicator.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is! Metric) {
      return Scaffold(
        appBar: AppBar(title: const Text('Metric')),
        body: const Center(child: Text('Metric not found')),
      );
    }
    final metric = args as Metric;
    final brightness = Theme.of(context).brightness;
    final color = metric.status.statusColor(brightness);
    final minMax = metric.range.toString().toMinMax();
    return Scaffold(
      appBar: AppBar(title: Text(metric.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  borderRadius: AppRadius.soft,
                  gradient: LinearGradient(colors: [color.withOpacity(0.22), color.withOpacity(0.08)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${metric.value} ${metric.unit}', style: Theme.of(context).textTheme.headlineSmall),
                          const SizedBox(height: AppSpacing.xs),
                          Row(children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 6),
                              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                              child: Text(metric.status.label(), style: TextStyle(color: color, fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text('Range ${metric.range}')
                          ])
                        ],
                      ),
                    ),
                    CircularMetricIndicator(
                      value: metric.value,
                      min: minMax.$1 ?? metric.value,
                      max: minMax.$2 ?? metric.value + 1,
                      color: color,
                    )
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('History', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              Container(
                decoration: BoxDecoration(borderRadius: AppRadius.soft, color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.25)),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: MetricLineChart(points: metric.history, color: color),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Trend ${metric.trend}', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}