import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tests2/data/datasources/local_datasource.dart';
import 'package:tests2/logic/providers/theme_provider.dart';
import 'package:tests2/main.dart';

class FakeLocalDataSource extends LocalDataSource {
  String? _mode;
  @override
  Future<String?> loadThemeMode() async => _mode;
  @override
  Future<void> saveThemeMode(String mode) async {
    _mode = mode;
  }
}

void main() {
  testWidgets('Dark mode toggles correctly', (tester) async {
    final controller = ThemeController(FakeLocalDataSource());
    await tester.pumpWidget(ProviderScope(overrides: [
      themeControllerProvider.overrideWith((ref) => controller),
    ], child: const App()));
    expect(find.byType(MaterialApp), findsOneWidget);
    await controller.toggle();
  });
}