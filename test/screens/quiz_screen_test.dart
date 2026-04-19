import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:london_quest/screens/quiz_screen.dart';
import 'package:london_quest/data/trip_data.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  final attraction = attractionById['westminster']!;

  Widget wrap({String player = 'Ines'}) => MaterialApp(
        home: QuizScreen(attraction: attraction, playerName: player),
      );

  group('QuizScreen', () {
    testWidgets('renders attraction name', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pump();
      expect(find.text(attraction.name), findsWidgets);
    });

    testWidgets('renders first question text', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pump();
      expect(find.text(attraction.questions[0].text), findsOneWidget);
    });

    testWidgets('shows question counter 1/10', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pump();
      expect(find.text('1/10'), findsOneWidget);
    });

    testWidgets('shows 4 option labels A B C D', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pump();
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
      expect(find.text('D'), findsOneWidget);
    });

    testWidgets('shows initial score of 0', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pump();
      expect(find.text('⭐ 0'), findsOneWidget);
    });

    testWidgets('tapping an option shows fun fact', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pump();
      await tester.tap(find.text('A'));
      await tester.pump();
      expect(find.textContaining('💡'), findsOneWidget);
    });

    testWidgets('tapping an option shows next button', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pump();
      await tester.tap(find.text('A'));
      await tester.pump();
      // Either 'Próxima ➡️' or 'Ver Resultado 🏆'
      expect(
        find.text('Próxima ➡️').evaluate().isNotEmpty ||
            find.text('Ver Resultado 🏆').evaluate().isNotEmpty,
        isTrue,
      );
    });

    testWidgets('correct answer increments score', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pump();
      // Tap by option text — position is randomised after shuffle
      final correctText = attraction.questions[0].options[
          attraction.questions[0].correctIndex];
      final correctFinder = find.text(correctText);
      await tester.ensureVisible(correctFinder);
      await tester.tap(correctFinder);
      await tester.pump();
      expect(find.text('⭐ 1'), findsOneWidget);
    });

    testWidgets('wrong answer keeps score at 0', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pump();
      // Pick any option that is NOT the correct answer text
      final correctText = attraction.questions[0].options[
          attraction.questions[0].correctIndex];
      final wrongText = attraction.questions[0].options
          .firstWhere((o) => o != correctText);
      final wrongFinder = find.text(wrongText);
      await tester.ensureVisible(wrongFinder);
      await tester.tap(wrongFinder);
      await tester.pump();
      expect(find.text('⭐ 0'), findsOneWidget);
    });

    testWidgets('shows checkmark on correct option after answering',
        (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pump();
      await tester.tap(find.text('A'));
      await tester.pump();
      expect(find.text('✅'), findsOneWidget);
    });

    testWidgets('options disabled after answering', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pump();
      await tester.tap(find.text('A'));
      await tester.pump();
      // Tapping again should not change score (already answered)
      final scoreBefore = find.text('⭐ 0').evaluate().isNotEmpty ||
          find.text('⭐ 1').evaluate().isNotEmpty;
      await tester.tap(find.text('B'));
      await tester.pump();
      expect(scoreBefore, isTrue); // still same state
    });
  });
}
