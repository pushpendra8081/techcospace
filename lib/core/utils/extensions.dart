import 'package:flutter/material.dart';
import '../../data/models/metric.dart';
import 'constants.dart';

extension MetricStatusX on MetricStatus {
  Color cardColor(Brightness brightness) {
    switch (this) {
      case MetricStatus.normal:
        return brightness == Brightness.dark
            ? AppColors.green.withOpacity(0.2)
            : AppColors.green.withOpacity(0.1);
      case MetricStatus.high:
        return brightness == Brightness.dark
            ? AppColors.orange.withOpacity(0.2)
            : AppColors.orange.withOpacity(0.1);
      case MetricStatus.low:
        return brightness == Brightness.dark
            ? AppColors.red.withOpacity(0.2)
            : AppColors.red.withOpacity(0.1);
    }
  }

  Color statusColor(Brightness brightness) {
    switch (this) {
      case MetricStatus.normal:
        return AppColors.green;
      case MetricStatus.high:
        return AppColors.orange;
      case MetricStatus.low:
        return AppColors.red;
    }
  }

  String label() {
    switch (this) {
      case MetricStatus.normal:
        return 'Normal';
      case MetricStatus.high:
        return 'High';
      case MetricStatus.low:
        return 'Low';
    }
  }
}

extension RangeParsing on String {
  (double?, double?) toMinMax() {
    final parts = split('-');
    if (parts.length != 2) return (null, null);
    final a = double.tryParse(parts[0].trim());
    final b = double.tryParse(parts[1].trim());
    return (a, b);
  }
}