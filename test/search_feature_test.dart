import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tests2/logic/providers/metrics_providers.dart';
import 'package:tests2/presentation/widgets/search_filter_bar.dart';

void main() {
  testWidgets('Search feature updates results', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: Scaffold(body: SearchFilterBar()))));
    await tester.enterText(find.byType(TextField), 'abc');
    await tester.pump();
    final container = ProviderScope.containerOf(tester.element(find.byType(SearchFilterBar)));
    expect(container.read(searchQueryProvider), 'abc');
  });
}