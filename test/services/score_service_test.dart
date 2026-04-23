import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:london_quest/services/score_service.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  // ── Player ──────────────────────────────────────────────────────────────

  group('ScoreService.player', () {
    test('getPlayer returns null when nothing saved', () async {
      expect(await ScoreService.getPlayer(), isNull);
    });

    test('savePlayer then getPlayer returns same value', () async {
      await ScoreService.savePlayer('Ines');
      expect(await ScoreService.getPlayer(), 'Ines');
    });

    test('clearPlayer removes saved player', () async {
      await ScoreService.savePlayer('Pedro');
      await ScoreService.clearPlayer();
      expect(await ScoreService.getPlayer(), isNull);
    });

    test('overwrite player', () async {
      await ScoreService.savePlayer('Ines');
      await ScoreService.savePlayer('Pedro');
      expect(await ScoreService.getPlayer(), 'Pedro');
    });
  });

  // ── Attraction scores ────────────────────────────────────────────────────

  group('ScoreService.attractionScore', () {
    test('returns 0 when not set', () async {
      expect(await ScoreService.getAttractionScore('Ines', 'westminster'), 0);
    });

    test('saves and retrieves score', () async {
      await ScoreService.saveAttractionScore('Ines', 'westminster', 7);
      expect(await ScoreService.getAttractionScore('Ines', 'westminster'), 7);
    });

    test('does NOT overwrite with lower score', () async {
      await ScoreService.saveAttractionScore('Ines', 'westminster', 8);
      await ScoreService.saveAttractionScore('Ines', 'westminster', 5);
      expect(await ScoreService.getAttractionScore('Ines', 'westminster'), 8);
    });

    test('does overwrite with higher score', () async {
      await ScoreService.saveAttractionScore('Ines', 'westminster', 5);
      await ScoreService.saveAttractionScore('Ines', 'westminster', 9);
      expect(await ScoreService.getAttractionScore('Ines', 'westminster'), 9);
    });

    test('scores are independent per player', () async {
      await ScoreService.saveAttractionScore('Ines', 'westminster', 7);
      await ScoreService.saveAttractionScore('Pedro', 'westminster', 3);
      expect(await ScoreService.getAttractionScore('Ines', 'westminster'), 7);
      expect(await ScoreService.getAttractionScore('Pedro', 'westminster'), 3);
    });

    test('scores are independent per attraction', () async {
      await ScoreService.saveAttractionScore('Ines', 'westminster', 7);
      await ScoreService.saveAttractionScore('Ines', 'trafalgar', 4);
      expect(await ScoreService.getAttractionScore('Ines', 'westminster'), 7);
      expect(await ScoreService.getAttractionScore('Ines', 'trafalgar'), 4);
    });
  });

  // ── Day / total scores ───────────────────────────────────────────────────

  group('ScoreService.dayScore', () {
    test('getDayScore sums attractions in that day', () async {
      await ScoreService.saveAttractionScore('Ines', 'westminster', 7);
      await ScoreService.saveAttractionScore('Ines', 'trafalgar', 5);
      expect(await ScoreService.getDayScore('Ines', 1), 12);
    });

    test('getDayScore ignores attractions from other days', () async {
      await ScoreService.saveAttractionScore('Ines', 'nhm', 10);
      expect(await ScoreService.getDayScore('Ines', 1), 0);
    });

    test('getDayScore returns 0 when no scores saved', () async {
      expect(await ScoreService.getDayScore('Ines', 2), 0);
    });
  });

  group('ScoreService.totalScore', () {
    test('getTotalScore sums across all attractions', () async {
      await ScoreService.saveAttractionScore('Ines', 'westminster', 7);
      await ScoreService.saveAttractionScore('Ines', 'nhm', 10);
      await ScoreService.saveAttractionScore('Ines', 'buckingham', 3);
      expect(await ScoreService.getTotalScore('Ines'), 20);
    });

    test('getTotalScore returns 0 when nothing saved', () async {
      expect(await ScoreService.getTotalScore('Pedro'), 0);
    });

    test('getTotalMaxScore returns 140', () {
      expect(ScoreService.getTotalMaxScore(), 140);
    });
  });

  // ── Schedule ─────────────────────────────────────────────────────────────

  group('ScoreService.schedule', () {
    test('getSchedule returns default when nothing saved', () async {
      final s = await ScoreService.getSchedule();
      expect(s.keys.toSet(), {1, 2, 3, 4, 5});
      expect(s[1], containsAll(['westminster', 'trafalgar']));
      expect(s[2], containsAll(['nhm', 'hydepark', 'sciencemuseum']));
    });

    test('saveSchedule persists and getSchedule returns it', () async {
      final custom = {
        1: ['trafalgar', 'westminster'],
        2: ['nhm'],
        3: ['hydepark', 'sciencemuseum'],
        4: ['britishmuseum', 'tussauds', 'buckingham',
            'toweroflondon', 'towerbridge', 'hmsbelfast',
            'stpauls', 'millennium',],
      };
      await ScoreService.saveSchedule(custom);
      final loaded = await ScoreService.getSchedule();
      expect(loaded[1], ['trafalgar', 'westminster']);
      expect(loaded[2], ['nhm']);
    });

    test('resetSchedule restores default', () async {
      await ScoreService.saveSchedule({1: ['trafalgar'], 2: [], 3: [], 4: []});
      await ScoreService.resetSchedule();
      final s = await ScoreService.getSchedule();
      expect(s[1], containsAll(['westminster', 'trafalgar']));
    });

    test('getSchedule handles corrupt data gracefully', () async {
      SharedPreferences.setMockInitialValues({'custom_schedule': '{bad json'});
      final s = await ScoreService.getSchedule();
      expect(s.keys.toSet(), {1, 2, 3, 4, 5}); // falls back to default
    });

    test('getDayScore respects custom schedule', () async {
      // Move westminster to day 2
      await ScoreService.saveSchedule({
        1: ['trafalgar'],
        2: ['nhm', 'hydepark', 'sciencemuseum', 'westminster'],
        3: ['britishmuseum', 'tussauds', 'buckingham'],
        4: ['toweroflondon', 'towerbridge', 'hmsbelfast', 'stpauls', 'millennium'],
      });
      await ScoreService.saveAttractionScore('Ines', 'westminster', 8);
      expect(await ScoreService.getDayScore('Ines', 1), 0);
      expect(await ScoreService.getDayScore('Ines', 2), 8);
    });
  });
}
