import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_color_picker/custom_picker/history_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_tooltip/super_tooltip.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  testWidgets('adding a swatch to the default history does not throw', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: HistoryColors(onColorChanged: (_) {})),
      ),
    );
    await tester.pumpAndSettle();

    // The defaults are seeded from a const list; adding to it used to throw
    // "Cannot add to an unmodifiable list".
    final int initialSwatches = tester
        .widgetList(find.byType(SuperTooltip))
        .length;
    expect(initialSwatches, greaterThan(0));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(
      tester.widgetList(find.byType(SuperTooltip)).length,
      initialSwatches + 1,
    );
  });
}
