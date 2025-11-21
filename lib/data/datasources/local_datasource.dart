import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/metric.dart';

class LocalDataSource {
  static const String metricsKey = 'metrics_data';
  static const String themeKey = 'theme_mode';

  Future<MetricsDataset> loadDefault() async {
    final s = await rootBundle.loadString('assets/data/metrics.json');
    final map = jsonDecode(s) as Map<String, dynamic>;
    return MetricsDataset.fromJson(map);
  }

  Future<MetricsDataset> loadPersistedOrDefault() async {
    final prefs = await SharedPreferences.getInstance();
    final persisted = prefs.getString(metricsKey);
    if (persisted != null) {
      final map = jsonDecode(persisted) as Map<String, dynamic>;
      return MetricsDataset.fromJson(map);
    }
    return loadDefault();
  }

  Future<void> saveMetrics(MetricsDataset dataset) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(metricsKey, dataset.toJsonString());
  }

  Future<String?> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(themeKey);
  }

  Future<void> saveThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeKey, mode);
  }
}