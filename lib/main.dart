import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'logic/providers/theme_provider.dart';
import 'presentation/screens/dashboard_screen.dart';
import 'presentation/screens/detail_screen.dart';
import 'presentation/screens/settings_screen.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeControllerProvider);
    return MaterialApp(
      title: 'Health Insights',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: mode,
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return _route(const DashboardScreen(), settings);
        }
        if (settings.name == '/detail') {
          return _route(const DetailScreen(), settings);
        }
        if (settings.name == '/settings') {
          return _route(const SettingsScreen(), settings);
        }
        return _route(const DashboardScreen(), settings);
      },
    );
  }

  PageRoute _route(Widget child, RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (context, a1, a2) => child,
      transitionsBuilder: (context, a1, a2, child) {
        final fade = CurvedAnimation(parent: a1, curve: Curves.easeOut);
        final slide = Tween<Offset>(begin: const Offset(0, 0.02), end: Offset.zero).animate(fade);
        return FadeTransition(opacity: fade, child: SlideTransition(position: slide, child: child));
      },
      transitionDuration: const Duration(milliseconds: 220),
      settings: settings,
    );
  }
}
