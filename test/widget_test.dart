import 'package:flutter_test/flutter_test.dart';
import 'package:london_quest/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const LondonQuestApp());
  });
}
