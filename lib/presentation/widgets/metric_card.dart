import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/extensions.dart';
import '../../data/models/metric.dart';

class MetricCard extends ConsumerWidget {
  final Metric metric;
  final VoidCallback onTap;
  const MetricCard({super.key, required this.metric, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;
    final color = metric.status.statusColor(brightness);
    final bg = metric.status.statusColor(brightness);
    final range = metric.range.toString();
    return Semantics(
      label: 'Metric ${metric.name} value ${metric.value} ${metric.unit} status ${metric.status.label()}',
      button: true,
      child: AnimatedContainer(
        duration: AppDurations.normal,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: AppRadius.soft,
          gradient: LinearGradient(colors: [bg.withOpacity(0.18), bg.withOpacity(0.06)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 6))],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.soft,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(color: color.withOpacity(0.18), shape: BoxShape.circle),
                      child: Icon(Icons.favorite_rounded, color: color),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(child: Text(metric.name, style: Theme.of(context).textTheme.titleMedium)),
                    Icon(Icons.chevron_right, color: color),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Text('${metric.value} ${metric.unit}', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(width: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 6),
                      decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                      child: Text(metric.status.label(), style: TextStyle(color: color, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text('Range $range', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.sm),
                const SizedBox(height: AppSpacing.xs),
              ],
            ),
          ),
        ),
      ),
    );
  }
}