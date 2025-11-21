import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/datasources/local_datasource.dart';
import '../../data/models/metric.dart';
import '../../data/repositories/metrics_repository.dart';

final localDataSourceProvider = Provider((ref) => LocalDataSource());
final metricsRepositoryProvider = Provider((ref) => MetricsRepository(ref.read(localDataSourceProvider)));

final metricsDatasetProvider = FutureProvider<MetricsDataset>((ref) async {
  return ref.read(metricsRepositoryProvider).getDataset();
});

final metricsProvider = Provider<List<Metric>>((ref) {
  final async = ref.watch(metricsDatasetProvider);
  return async.maybeWhen(data: (d) => d.metrics, orElse: () => []);
});

final userNameProvider = Provider<String?>((ref) {
  final async = ref.watch(metricsDatasetProvider);
  return async.maybeWhen(data: (d) => d.user, orElse: () => null);
});

final lastUpdatedProvider = Provider<String?>((ref) {
  final async = ref.watch(metricsDatasetProvider);
  return async.maybeWhen(data: (d) => d.lastUpdated, orElse: () => null);
});

final searchQueryProvider = StateProvider<String>((ref) => '');
final statusFilterProvider = StateProvider<Set<MetricStatus>>((ref) => {});
final valueRangeFilterProvider = StateProvider<(double, double)?>((ref) => null);

final filteredMetricsProvider = Provider<List<Metric>>((ref) {
  final metrics = ref.watch(metricsProvider);
  final q = ref.watch(searchQueryProvider);
  final statuses = ref.watch(statusFilterProvider);
  final range = ref.watch(valueRangeFilterProvider);
  Iterable<Metric> m = metrics;
  if (q.isNotEmpty) {
    final lower = q.toLowerCase();
    m = m.where((e) => e.name.toLowerCase().contains(lower));
  }
  if (statuses.isNotEmpty) {
    m = m.where((e) => statuses.contains(e.status));
  }
  if (range != null) {
    m = m.where((e) => e.value >= range.$1 && e.value <= range.$2);
  }
  return m.toList();
});

final metricsStatsProvider = Provider<(double min, double max)?>((ref) {
  final metrics = ref.watch(metricsProvider);
  if (metrics.isEmpty) return null;
  double min = metrics.first.value;
  double max = metrics.first.value;
  for (final m in metrics) {
    if (m.value < min) min = m.value;
    if (m.value > max) max = m.value;
  }
  return (min, max);
});