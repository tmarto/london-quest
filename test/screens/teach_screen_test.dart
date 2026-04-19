import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:london_quest/screens/teach_screen.dart';
import 'package:london_quest/data/trip_data.dart';

void main() {
  final attraction = attractionById['westminster']!;

  Widget wrap() => MaterialApp(home: TeachScreen(attraction: attraction));

  group('TeachScreen', () {
    testWidgets('renders attraction name', (tester) async {
      await tester.pumpWidget(wrap());
      expect(find.text(attraction.name), findsOneWidget);
    });

    testWidgets('shows teaching mode header', (tester) async {
      await tester.pumpWidget(wrap());
      expect(find.text('📖 Modo Ensino'), findsOneWidget);
    });

    testWidgets('shows PERGUNTA label', (tester) async {
      await tester.pumpWidget(wrap());
      expect(find.text('PERGUNTA'), findsOneWidget);
    });

    testWidgets('shows curiosidade label', (tester) async {
      await tester.pumpWidget(wrap());
      expect(find.textContaining('CURIOSIDADE'), findsOneWidget);
    });

    testWidgets('shows progress counter 1/10', (tester) async {
      await tester.pumpWidget(wrap());
      expect(find.text('1/10'), findsOneWidget);
    });

    testWidgets('shows first question text', (tester) async {
      await tester.pumpWidget(wrap());
      expect(find.text(attraction.questions[0].text), findsOneWidget);
    });

    testWidgets('shows fun fact for first question', (tester) async {
      await tester.pumpWidget(wrap());
      expect(find.textContaining(attraction.questions[0].funFact),
          findsOneWidget,);
    });

    testWidgets('prev button disabled on first question', (tester) async {
      await tester.pumpWidget(wrap());
      final btn = tester.widget<OutlinedButton>(
        find.widgetWithText(OutlinedButton, '⬅️ Anterior'),
      );
      expect(btn.onPressed, isNull);
    });

    testWidgets('next button navigates to question 2', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.tap(find.text('Próxima ➡️'));
      await tester.pump();
      expect(find.text('2/10'), findsOneWidget);
      expect(find.text(attraction.questions[1].text), findsOneWidget);
    });

    testWidgets('prev button enabled after navigating to question 2',
        (tester) async {
      await tester.pumpWidget(wrap());
      await tester.tap(find.text('Próxima ➡️'));
      await tester.pump();
      final btn = tester.widget<OutlinedButton>(
        find.widgetWithText(OutlinedButton, '⬅️ Anterior'),
      );
      expect(btn.onPressed, isNotNull);
    });

    testWidgets('prev button navigates back to question 1', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.tap(find.text('Próxima ➡️'));
      await tester.pump();
      await tester.tap(find.text('⬅️ Anterior'));
      await tester.pump();
      expect(find.text('1/10'), findsOneWidget);
    });

    testWidgets('back arrow icon exists', (tester) async {
      await tester.pumpWidget(wrap());
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('correct option highlighted with checkmark', (tester) async {
      await tester.pumpWidget(wrap());
      expect(find.text('✅'), findsOneWidget);
    });
  });
}
