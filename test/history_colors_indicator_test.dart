import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_color_picker/custom_picker/history_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('a multi-page history renders the page indicator', (
    tester,
  ) async {
    // 12 saved swatches spill onto a second page, which is the only case that
    // renders the smooth_page_indicator widget.
    SharedPreferences.setMockInitialValues(<String, Object>{
      'flutter.history_colors': <String>[
        '0061FD',
        '982ABC',
        'B92D5D',
        'FF6A00',
        'FFAB01',
        'FEFB41',
        '76BB40',
        '01C7FC',
        '3A87FD',
        '5E30EB',
        'BE38F3',
        'E63B7A',
      ],
    });

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: HistoryColors(onColorChanged: (_) {})),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(AnimatedSmoothIndicator), findsOneWidget);
  });
}
