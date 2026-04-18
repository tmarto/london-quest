import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:london_quest/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const LondonQuestApp());
    // Advance past the 900 ms splash delay so timer is drained
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
  });
}
