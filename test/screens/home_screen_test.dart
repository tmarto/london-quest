import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:london_quest/screens/home_screen.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  Widget _wrap(String player) =>
      MaterialApp(home: HomeScreen(playerName: player));

  group('HomeScreen - Ines', () {
    testWidgets('shows Inês display name', (tester) async {
      await tester.pumpWidget(_wrap('Ines'));
      await tester.pump();
      expect(find.text('Inês'), findsOneWidget);
    });

    testWidgets('shows total score card', (tester) async {
      await tester.pumpWidget(_wrap('Ines'));
      await tester.pump();
      expect(find.text('Pontos Totais da Viagem'), findsOneWidget);
    });

    testWidgets('shows 4 day cards', (tester) async {
      await tester.pumpWidget(_wrap('Ines'));
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Dia 1'), findsOneWidget);
      expect(find.text('Dia 2'), findsOneWidget);
      expect(find.text('Dia 3'), findsOneWidget);
      expect(find.text('Dia 4'), findsOneWidget);
    });

    testWidgets('does NOT show edit icon for Ines', (tester) async {
      await tester.pumpWidget(_wrap('Ines'));
      await tester.pump();
      expect(find.byIcon(Icons.edit_calendar), findsNothing);
    });

    testWidgets('shows Mudar jogador button', (tester) async {
      await tester.pumpWidget(_wrap('Ines'));
      await tester.pump();
      expect(find.text('Mudar jogador'), findsOneWidget);
    });
  });

  group('HomeScreen - Pedro', () {
    testWidgets('shows Pedro display name', (tester) async {
      await tester.pumpWidget(_wrap('Pedro'));
      await tester.pump();
      expect(find.text('Pedro'), findsOneWidget);
    });
  });

  group('HomeScreen - Ana', () {
    testWidgets('shows Ana display name', (tester) async {
      await tester.pumpWidget(_wrap('Ana'));
      await tester.pump();
      expect(find.text('Ana'), findsOneWidget);
    });

    testWidgets('shows edit calendar icon for Ana', (tester) async {
      await tester.pumpWidget(_wrap('Ana'));
      await tester.pump();
      expect(find.byIcon(Icons.edit_calendar), findsOneWidget);
    });
  });
}
