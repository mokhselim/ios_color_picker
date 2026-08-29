import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_color_picker/custom_picker/ios_color_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  testWidgets('the sheet does not overflow on a small landscape surface', (
    tester,
  ) async {
    // iPhone SE in landscape: the sheet's intrinsic height (340 +
    // componentsHeight) is taller than the screen.
    tester.view.physicalSize = const Size(1334, 750);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: IosColorPicker(onColorSelected: (_) {})),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(SingleChildScrollView), findsWidgets);

    // The sheet is clamped to the available height instead of overflowing it.
    final Size sheet = tester.getSize(
      find
          .ancestor(
            of: find.byType(SingleChildScrollView),
            matching: find.byType(Container),
          )
          .first,
    );
    expect(sheet.height, lessThanOrEqualTo(375.0));
  });
}
