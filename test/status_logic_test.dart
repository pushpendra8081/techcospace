import 'package:flutter_test/flutter_test.dart';
import 'package:tests2/data/models/metric.dart';

void main() {
  test('Status logic mapping', () {
    final mLow = Metric.fromJson({
      'name': 'A',
      'value': 1,
      'unit': 'u',
      'status': 'low',
      'range': '0 - 2',
      'history': [1]
    });
    final mHigh = Metric.fromJson({
      'name': 'B',
      'value': 3,
      'unit': 'u',
      'status': 'high',
      'range': '0 - 2',
      'history': [3]
    });
    final mNormal = Metric.fromJson({
      'name': 'C',
      'value': 1.5,
      'unit': 'u',
      'status': 'normal',
      'range': '0 - 2',
      'history': [1.5]
    });
    expect(mLow.status, MetricStatus.low);
    expect(mHigh.status, MetricStatus.high);
    expect(mNormal.status, MetricStatus.normal);
  });
}