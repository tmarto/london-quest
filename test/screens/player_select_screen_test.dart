import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:london_quest/screens/player_select_screen.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  Widget wrap() => const MaterialApp(home: PlayerSelectScreen());

  group('PlayerSelectScreen', () {
    testWidgets('renders London Quest title', (tester) async {
      await tester.pumpWidget(wrap());
      expect(find.text('LONDON QUEST'), findsOneWidget);
    });

    testWidgets('renders Quem és tu prompt', (tester) async {
      await tester.pumpWidget(wrap());
      expect(find.text('Quem és tu?'), findsOneWidget);
    });

    testWidgets('renders all 3 player buttons', (tester) async {
      await tester.pumpWidget(wrap());
      expect(find.text('Inês'), findsOneWidget);
      expect(find.text('Pedro'), findsOneWidget);
      expect(find.text('Ana'), findsOneWidget);
    });

    testWidgets('Ana button has Ensinar label', (tester) async {
      await tester.pumpWidget(wrap());
      expect(find.text('Ensinar'), findsOneWidget);
    });

    testWidgets('player emojis are shown', (tester) async {
      await tester.pumpWidget(wrap());
      expect(find.text('👧'), findsOneWidget);
      expect(find.text('👦'), findsOneWidget);
      expect(find.text('👩'), findsOneWidget);
    });
  });
}
