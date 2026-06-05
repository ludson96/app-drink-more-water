import 'package:flutter_test/flutter_test.dart';

import 'package:app_drink_more_water/main.dart';
import 'package:app_drink_more_water/controllers/water_controller.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final controller = WaterController();
    // Build our app and trigger a frame.
    await tester.pumpWidget(DrinkMoreWaterApp(controller: controller));

    // Verify that the title is present.
    expect(find.text('Beber Água'), findsWidgets);

    // Verify that 0% progress is shown.
    expect(find.text('0%'), findsOneWidget);

    // Verify the daily target text is displayed
    expect(find.text('0 ml / 2000 ml'), findsOneWidget);

    // Tap the '100 ml' add button.
    await tester.tap(find.text('100 ml'));
    await tester.pump(); // trigger rebuild

    // Verify that progress has updated
    expect(find.text('100 ml / 2000 ml'), findsOneWidget);
    expect(find.text('5%'), findsOneWidget);
  });
}
