import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:london_quest/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  group('E2E: player select → home → day → quiz', () {
    testWidgets('shows player select on first launch', (tester) async {
      await tester.pumpWidget(const LondonQuestApp());
      // Wait past splash screen
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(find.text('LONDON QUEST'), findsOneWidget);
      expect(find.text('Quem és tu?'), findsOneWidget);
      expect(find.text('Inês'), findsOneWidget);
      expect(find.text('Pedro'), findsOneWidget);
    });

    testWidgets('selecting Pedro navigates to home screen', (tester) async {
      await tester.pumpWidget(const LondonQuestApp());
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pedro'));
      await tester.pumpAndSettle();

      expect(find.text('Pedro'), findsOneWidget);
      expect(find.text('Pontos Totais da Viagem'), findsOneWidget);
      expect(find.text('Dia 1'), findsOneWidget);
    });

    testWidgets('tapping a day card opens day screen', (tester) async {
      await tester.pumpWidget(const LondonQuestApp());
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pedro'));
      await tester.pumpAndSettle();

      // Tap first day card
      await tester.tap(find.text('Westminster, Trafalgar & Piccadilly'));
      await tester.pumpAndSettle();

      expect(find.text('Atrações do dia'), findsOneWidget);
      expect(find.text('⭐ Pontos do dia'), findsOneWidget);
    });

    testWidgets('saved player bypasses player select', (tester) async {
      SharedPreferences.setMockInitialValues({'current_player': 'Ines'});
      await tester.pumpWidget(const LondonQuestApp());
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      // Should go directly to home, not player select
      expect(find.text('Inês'), findsOneWidget);
      expect(find.text('Pontos Totais da Viagem'), findsOneWidget);
    });

    testWidgets('Mudar jogador returns to player select', (tester) async {
      SharedPreferences.setMockInitialValues({'current_player': 'Pedro'});
      await tester.pumpWidget(const LondonQuestApp());
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Mudar jogador'));
      await tester.pumpAndSettle();

      expect(find.text('LONDON QUEST'), findsOneWidget);
      expect(find.text('Quem és tu?'), findsOneWidget);
    });
  });
}
