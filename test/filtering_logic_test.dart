import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tests2/data/models/metric.dart';
import 'package:tests2/logic/providers/metrics_providers.dart';

void main() {
  test('Filtering logic by search and status', () async {
    final container = ProviderContainer(overrides: [
      metricsProvider.overrideWithValue([
        Metric(name: 'Hemoglobin', value: 9.5, unit: 'g/dL', status: MetricStatus.low, range: '12 - 16', history: [9.2, 9.3, 9.5]),
        Metric(name: 'Vitamin D', value: 20, unit: 'ng/mL', status: MetricStatus.low, range: '30 - 80', history: [18, 19, 20]),
        Metric(name: 'WBC Count', value: 7.5, unit: 'K/uL', status: MetricStatus.normal, range: '4 - 11', history: [7.2, 7.3, 7.5]),
      ]),
    ]);
    container.read(searchQueryProvider.notifier).state = 'vit';
    container.read(statusFilterProvider.notifier).state = {MetricStatus.low};
    final result = container.read(filteredMetricsProvider);
    expect(result.length, 1);
    expect(result.first.name, 'Vitamin D');
  });
}