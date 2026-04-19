import 'package:flutter_test/flutter_test.dart';
import 'package:london_quest/data/trip_data.dart';

void main() {
  group('tripDays', () {
    test('has exactly 4 days', () => expect(tripDays.length, 4));

    test('day numbers are 1 through 4', () {
      final numbers = tripDays.map((d) => d.number).toList()..sort();
      expect(numbers, [1, 2, 3, 4]);
    });

    test('all days have non-empty titles', () {
      for (final d in tripDays) {
        expect(d.title, isNotEmpty, reason: 'Day ${d.number} has empty title');
      }
    });

    test('all days have attractions', () {
      for (final d in tripDays) {
        expect(d.attractions, isNotEmpty,
            reason: 'Day ${d.number} has no attractions',);
      }
    });

    test('day 1 contains Westminster and Trafalgar', () {
      final day1 = tripDays.firstWhere((d) => d.number == 1);
      final ids = day1.attractions.map((a) => a.id).toList();
      expect(ids, containsAll(['westminster', 'trafalgar']));
    });

    test('day 4 contains Tower of London and Tower Bridge', () {
      final day4 = tripDays.firstWhere((d) => d.number == 4);
      final ids = day4.attractions.map((a) => a.id).toList();
      expect(ids, containsAll(['toweroflondon', 'towerbridge']));
    });
  });

  group('attractionById', () {
    test('has exactly 13 attractions', () =>
        expect(attractionById.length, 13),);

    test('all attraction IDs are unique across days', () {
      final ids = tripDays
          .expand((d) => d.attractions.map((a) => a.id))
          .toList();
      expect(ids.toSet().length, ids.length);
    });

    test('every day attraction is in attractionById', () {
      for (final day in tripDays) {
        for (final a in day.attractions) {
          expect(attractionById[a.id], isNotNull,
              reason: '${a.id} missing from attractionById',);
        }
      }
    });

    test('total question count is 130', () {
      final total =
          attractionById.values.fold(0, (sum, a) => sum + a.questions.length);
      expect(total, 130);
    });

    test('every attraction has exactly 10 questions', () {
      for (final a in attractionById.values) {
        expect(a.questions.length, 10,
            reason: '${a.name} has ${a.questions.length} questions, expected 10',);
      }
    });

    test('every question has exactly 4 options', () {
      for (final a in attractionById.values) {
        for (final q in a.questions) {
          expect(q.options.length, 4,
              reason: '"${q.text}" has ${q.options.length} options',);
        }
      }
    });

    test('every correctIndex is in range 0–3', () {
      for (final a in attractionById.values) {
        for (final q in a.questions) {
          expect(q.correctIndex, inInclusiveRange(0, 3),
              reason: '"${q.text}" has invalid correctIndex ${q.correctIndex}',);
        }
      }
    });

    test('all attractions have non-empty names', () {
      for (final a in attractionById.values) {
        expect(a.name, isNotEmpty);
      }
    });

    test('all attractions have non-empty imageUrl', () {
      for (final a in attractionById.values) {
        expect(a.imageUrl, isNotEmpty,
            reason: '${a.name} has empty imageUrl',);
      }
    });
  });

  group('defaultSchedule', () {
    test('has 4 days', () => expect(defaultSchedule.length, 4));

    test('contains all 13 attraction IDs', () {
      final ids = defaultSchedule.values.expand((list) => list).toSet();
      expect(ids, equals(attractionById.keys.toSet()));
    });

    test('no attraction appears in multiple days', () {
      final allIds = defaultSchedule.values.expand((list) => list).toList();
      expect(allIds.toSet().length, allIds.length,
          reason: 'Duplicate attraction IDs found in default schedule',);
    });

    test('matches tripDays attraction order', () {
      for (final day in tripDays) {
        final expected = day.attractions.map((a) => a.id).toList();
        expect(defaultSchedule[day.number], expected);
      }
    });
  });
}
