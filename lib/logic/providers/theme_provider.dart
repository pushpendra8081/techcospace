import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/datasources/local_datasource.dart';
import 'metrics_providers.dart';

class ThemeController extends StateNotifier<ThemeMode> {
  final LocalDataSource dataSource;
  ThemeController(this.dataSource) : super(ThemeMode.system) {
    _load();
  }

  Future<void> _load() async {
    final s = await dataSource.loadThemeMode();
    if (s == 'light') state = ThemeMode.light;
    if (s == 'dark') state = ThemeMode.dark;
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;
    await dataSource.saveThemeMode(mode.name);
  }

  Future<void> toggle() async {
    if (state == ThemeMode.dark) {
      await set(ThemeMode.light);
    } else {
      await set(ThemeMode.dark);
    }
  }
}

final themeControllerProvider = StateNotifierProvider<ThemeController, ThemeMode>((ref) {
  final ds = ref.read(localDataSourceProvider);
  return ThemeController(ds);
});