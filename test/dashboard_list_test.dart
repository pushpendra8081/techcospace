import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tests2/data/models/metric.dart';
import 'package:tests2/logic/providers/metrics_providers.dart';
import 'package:tests2/presentation/screens/dashboard_screen.dart';

void main() {
  testWidgets('List displays properly', (tester) async {
    final metrics = [
      Metric(name: 'A', value: 1, unit: 'u', status: MetricStatus.normal, range: '0 - 2', history: [1]),
      Metric(name: 'B', value: 3, unit: 'u', status: MetricStatus.high, range: '0 - 2', history: [3]),
    ];
    await tester.pumpWidget(ProviderScope(overrides: [
      metricsDatasetProvider.overrideWithValue(AsyncData(MetricsDataset(user: 'Alex', lastUpdated: '2024-01-15', metrics: metrics))),
      metricsProvider.overrideWithValue(metrics),
      filteredMetricsProvider.overrideWithValue(metrics),
    ], child: const MaterialApp(home: DashboardScreen())));
    await tester.pumpAndSettle();
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
  });
}