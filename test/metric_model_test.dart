import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tests2/data/models/metric.dart';

void main() {
  test('Metric model parsing', () {
    const s = '{"name":"Hemoglobin","value":9.5,"unit":"g/dL","status":"low","range":"12 - 16","history":[9.2,9.3,9.5]}';
    final map = jsonDecode(s) as Map<String, dynamic>;
    final m = Metric.fromJson(map);
    expect(m.name, 'Hemoglobin');
    expect(m.value, 9.5);
    expect(m.unit, 'g/dL');
    expect(m.status, MetricStatus.low);
    expect(m.history.length, 3);
    expect(m.trend, 'up');
  });
}