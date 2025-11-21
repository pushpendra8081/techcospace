import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tests2/data/models/metric.dart';
import 'package:tests2/presentation/widgets/metric_card.dart';

void main() {
  testWidgets('Metric card renders correctly', (tester) async {
    final m = Metric(name: 'Platelets', value: 210, unit: 'K/uL', status: MetricStatus.normal, range: '150 - 450', history: [205, 208, 210]);
    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: MetricCard(metric: m, onTap: () {}))));
    expect(find.text('Platelets'), findsOneWidget);
    expect(find.text('210 K/uL'), findsOneWidget);
    expect(find.text('Normal'), findsOneWidget);
    expect(find.textContaining('Range'), findsOneWidget);
  });
}