import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:london_quest/screens/result_screen.dart';
import 'package:london_quest/data/trip_data.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  final attraction = attractionById['westminster']!;

  Widget wrap({int score = 7, int total = 10, String player = 'Ines'}) =>
      MaterialApp(
        home: ResultScreen(
          attraction: attraction,
          playerName: player,
          score: score,
          total: total,
        ),
      );

  group('ResultScreen', () {
    testWidgets('renders attraction name', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pump();
      expect(find.text(attraction.name), findsOneWidget);
    });

    testWidgets('shows score number', (tester) async {
      await tester.pumpWidget(wrap(score: 7));
      await tester.pump();
      expect(find.text('7'), findsOneWidget);
    });

    testWidgets('shows total label', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pump();
      expect(find.text('de 10 certas'), findsOneWidget);
    });

    testWidgets('shows Tentar de Novo button', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pump();
      expect(find.text('Tentar de Novo 🔄'), findsOneWidget);
    });

    testWidgets('shows Voltar button', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pump();
      expect(find.text('Voltar às Atrações ⬅️'), findsOneWidget);
    });

    testWidgets('perfect score shows trophy emoji', (tester) async {
      await tester.pumpWidget(wrap(score: 10, total: 10));
      await tester.pump();
      expect(find.text('🏆'), findsOneWidget);
    });

    testWidgets('perfect score message mentions player name', (tester) async {
      await tester.pumpWidget(wrap(score: 10, total: 10));
      await tester.pump();
      expect(find.textContaining('Inês'), findsOneWidget);
    });

    testWidgets('low score shows motivational message', (tester) async {
      await tester.pumpWidget(wrap(score: 2, total: 10));
      await tester.pump();
      expect(find.textContaining('Não desistas'), findsOneWidget);
    });

    testWidgets('score >= 80% shows star emoji', (tester) async {
      await tester.pumpWidget(wrap(score: 8, total: 10));
      await tester.pump();
      expect(find.text('🌟'), findsOneWidget);
    });

    testWidgets('score >= 60% and < 80% shows happy face', (tester) async {
      await tester.pumpWidget(wrap(score: 7, total: 10));
      await tester.pump();
      // 7/10 = 70%, between 60% and 80% → 😄
      expect(find.text('😄'), findsOneWidget);
    });

    testWidgets('score >= 40% and < 60% shows thumbs up', (tester) async {
      await tester.pumpWidget(wrap(score: 4, total: 10));
      await tester.pump();
      expect(find.text('👍'), findsOneWidget);
    });

    testWidgets('Pedro name displayed correctly in message', (tester) async {
      await tester.pumpWidget(wrap(score: 10, total: 10, player: 'Pedro'));
      await tester.pump();
      expect(find.textContaining('Pedro'), findsWidgets);
    });
  });
}
