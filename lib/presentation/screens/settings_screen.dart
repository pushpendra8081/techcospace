import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/constants.dart';
import '../../logic/providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.25),
              borderRadius: AppRadius.soft,
            ),
            child: ListTile(
              title: const Text('Dark mode'),
              subtitle: const Text('Adaptive status colors and smooth transitions'),
              trailing: Switch(value: mode == ThemeMode.dark, onChanged: (_) => ref.read(themeControllerProvider.notifier).toggle()),
            ),
          ),
        ],
      ),
    );
  }
}