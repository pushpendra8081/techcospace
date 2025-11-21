import 'dart:convert';

enum MetricStatus { low, normal, high }

class Metric {
  final String name;
  final double value;
  final String unit;
  final MetricStatus status;
  final String range;
  final List<double> history;
  const Metric({
    required this.name,
    required this.value,
    required this.unit,
    required this.status,
    required this.range,
    required this.history,
  });

  factory Metric.fromJson(Map<String, dynamic> json) {
    return Metric(
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      unit: json['unit'] as String,
      status: _statusFromString(json['status'] as String),
      range: json['range'] as String,
      history: (json['history'] as List).map((e) => (e as num).toDouble()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'unit': unit,
      'status': status.name,
      'range': range,
      'history': history,
    };
  }

  String get trend {
    if (history.length < 2) return 'stable';
    final diff = history.last - history[history.length - 2];
    if (diff.abs() < 0.01) return 'stable';
    return diff > 0 ? 'up' : 'down';
  }

  static MetricStatus _statusFromString(String s) {
    switch (s.toLowerCase()) {
      case 'low':
        return MetricStatus.low;
      case 'normal':
        return MetricStatus.normal;
      case 'high':
        return MetricStatus.high;
      default:
        return MetricStatus.normal;
    }
  }
}

class MetricsDataset {
  final String user;
  final String lastUpdated;
  final List<Metric> metrics;
  const MetricsDataset({required this.user, required this.lastUpdated, required this.metrics});

  factory MetricsDataset.fromJson(Map<String, dynamic> json) {
    return MetricsDataset(
      user: json['user'] as String,
      lastUpdated: json['last_updated'] as String,
      metrics: (json['metrics'] as List).map((e) => Metric.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'last_updated': lastUpdated,
      'metrics': metrics.map((e) => e.toJson()).toList(),
    };
  }

  String toJsonString() => jsonEncode(toJson());
}