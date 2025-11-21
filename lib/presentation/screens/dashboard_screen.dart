import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/utils/constants.dart';
import '../../data/models/metric.dart';
import '../../logic/providers/metrics_providers.dart';
import '../widgets/metric_card.dart';
import '../widgets/search_filter_bar.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataset = ref.watch(metricsDatasetProvider);
    final metrics = ref.watch(filteredMetricsProvider);
    final user = ref.watch(userNameProvider);
    final last = ref.watch(lastUpdatedProvider);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: AppSpacing.lg),
            CircleAvatar(child: Text(user != null && user.isNotEmpty ? user[0] : 'A')),
            const SizedBox(width: AppSpacing.sm),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Health Metrics', style: Theme.of(context).textTheme.titleMedium),
              if (user != null) Text(user, style: Theme.of(context).textTheme.bodySmall),
            ])
          ],
        ),
        actions: [
          IconButton(onPressed: () => Navigator.pushNamed(context, '/settings'), icon: const Icon(Icons.tune))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (last != null)
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 18),
                    const SizedBox(width: AppSpacing.xs),
                    Text('Last updated $last')
                  ],
                ),
              const SizedBox(height: AppSpacing.sm),
              const SearchFilterBar(),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: dataset.when(
                  data: (_) => _ResponsiveList(metrics: metrics),
                  loading: () => const _ShimmerList(),
                  error: (e, _) => Center(child: Text('Error')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ResponsiveList extends StatelessWidget {
  final List<Metric> metrics;
  const _ResponsiveList({required this.metrics});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isGrid = width > 700;
    if (!isGrid) {
      return ListView.separated(
        itemCount: metrics.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, i) {
          final m = metrics[i];
          return Hero(
            tag: m.name,
            child: MetricCard(
              metric: m,
              onTap: () => Navigator.pushNamed(context, '/detail', arguments: m),
            ),
          );
        },
      );
    }
    return GridView.builder(
      itemCount: metrics.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: AppSpacing.sm, crossAxisSpacing: AppSpacing.sm, childAspectRatio: 2.8),
      itemBuilder: (context, i) {
        final m = metrics[i];
        return Hero(
          tag: m.name,
          child: MetricCard(metric: m, onTap: () => Navigator.pushNamed(context, '/detail', arguments: m)),
        );
      },
    );
  }
}

class _ShimmerList extends StatelessWidget {
  const _ShimmerList();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(height: 92, decoration: const BoxDecoration(color: Colors.white, borderRadius: AppRadius.soft)),
        );
      },
    );
  }
}