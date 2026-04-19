import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:london_quest/main.dart';

void main() {
  testWidgets('App smoke test - renders without crash', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const LondonQuestApp());
    // Advance past the 900 ms splash timer
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
  });

  testWidgets('App smoke test - with saved player navigates to HomeScreen',
      (tester) async {
    SharedPreferences.setMockInitialValues({'current_player': 'Pedro'});
    await tester.pumpWidget(const LondonQuestApp());
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    // HomeScreen should be visible
    expect(find.text('Pedro'), findsOneWidget);
  });
}
