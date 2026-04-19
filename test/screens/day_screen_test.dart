import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:london_quest/screens/day_screen.dart';
import 'package:london_quest/data/trip_data.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  final day1 = tripDays.firstWhere((d) => d.number == 1);

  Widget wrap(String player) =>
      MaterialApp(home: DayScreen(day: day1, playerName: player));

  group('DayScreen', () {
    testWidgets('shows day score card', (tester) async {
      await tester.pumpWidget(wrap('Ines'));
      await tester.pump();
      expect(find.text('⭐ Pontos do dia'), findsOneWidget);
    });

    testWidgets('shows attractions section label', (tester) async {
      await tester.pumpWidget(wrap('Ines'));
      await tester.pump();
      expect(find.text('Atrações do dia'), findsOneWidget);
    });

    testWidgets('shows Fazer Quiz buttons for Ines', (tester) async {
      await tester.pumpWidget(wrap('Ines'));
      await tester.pump();
      expect(find.text('▶ Fazer Quiz'), findsWidgets);
    });

    testWidgets('shows Ensinar buttons for Ana', (tester) async {
      await tester.pumpWidget(wrap('Ana'));
      await tester.pump();
      expect(find.text('📖 Ensinar'), findsWidgets);
    });

    testWidgets('shows Fazer Quiz buttons for Pedro', (tester) async {
      await tester.pumpWidget(wrap('Pedro'));
      await tester.pump();
      expect(find.text('▶ Fazer Quiz'), findsWidgets);
    });

    testWidgets('shows day 1 attraction names', (tester) async {
      await tester.pumpWidget(wrap('Ines'));
      await tester.pump();
      final day1AttractionName = attractionById['westminster']!.name;
      expect(find.text(day1AttractionName), findsOneWidget);
    });

    testWidgets('shows score as 0 initially', (tester) async {
      await tester.pumpWidget(wrap('Pedro'));
      await tester.pump();
      // Score summary format: "0 / N"
      expect(find.textContaining('0'), findsWidgets);
    });

    testWidgets('day header shows day number', (tester) async {
      await tester.pumpWidget(wrap('Ines'));
      expect(find.textContaining('Dia 1'), findsWidgets);
    });

    testWidgets('back button exists', (tester) async {
      await tester.pumpWidget(wrap('Ines'));
      await tester.pump();
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });
  });
}
