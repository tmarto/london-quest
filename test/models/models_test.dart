import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:london_quest/models/attraction.dart';
import 'package:london_quest/models/day.dart';
import 'package:london_quest/models/question.dart';

// Shared fixtures
const _q1 = Question(
  text: 'What is this?',
  options: ['A', 'B', 'C', 'D'],
  correctIndex: 0,
  funFact: 'Interesting fact.',
);

const _q2 = Question(
  text: 'How many?',
  options: ['1', '2', '3', '4'],
  correctIndex: 2,
  funFact: 'Another fact.',
  imageUrl: 'https://example.com/img.jpg',
);

const _attraction1 = Attraction(
  id: 'test_a',
  name: 'Test Attraction A',
  emoji: '🏛️',
  color: Color(0xFF123456),
  description: 'A test attraction.',
  imageUrl: 'https://example.com/a.jpg',
  questions: [_q1, _q2],
);

const _attraction2 = Attraction(
  id: 'test_b',
  name: 'Test Attraction B',
  emoji: '🦁',
  color: Color(0xFF654321),
  description: 'Another test attraction.',
  imageUrl: 'https://example.com/b.jpg',
  questions: [_q1, _q2, _q1],
);

void main() {
  // ── Question ─────────────────────────────────────────────────────────────

  group('Question', () {
    test('stores text', () => expect(_q1.text, 'What is this?'));
    test('stores options', () => expect(_q1.options, ['A', 'B', 'C', 'D']));
    test('stores correctIndex', () => expect(_q1.correctIndex, 0));
    test('stores funFact', () => expect(_q1.funFact, 'Interesting fact.'));
    test('imageUrl defaults to null', () => expect(_q1.imageUrl, isNull));
    test('imageUrl can be set', () =>
        expect(_q2.imageUrl, 'https://example.com/img.jpg'),);
  });

  // ── Attraction ────────────────────────────────────────────────────────────

  group('Attraction', () {
    test('stores id', () => expect(_attraction1.id, 'test_a'));
    test('stores name', () => expect(_attraction1.name, 'Test Attraction A'));
    test('stores emoji', () => expect(_attraction1.emoji, '🏛️'));
    test('stores description', () => expect(_attraction1.description, 'A test attraction.'));
    test('stores imageUrl', () =>
        expect(_attraction1.imageUrl, 'https://example.com/a.jpg'),);
    test('maxScore equals question count', () =>
        expect(_attraction1.maxScore, 2),);
    test('maxScore reflects all questions', () =>
        expect(_attraction2.maxScore, 3),);
    test('questions list is accessible', () =>
        expect(_attraction1.questions.length, 2),);
  });

  // ── Day ───────────────────────────────────────────────────────────────────

  group('Day', () {
    const day = Day(
      number: 2,
      date: '30 Abril',
      title: 'Test Day',
      emoji: '🦕',
      attractions: [_attraction1, _attraction2],
    );

    test('stores number', () => expect(day.number, 2));
    test('stores date', () => expect(day.date, '30 Abril'));
    test('stores title', () => expect(day.title, 'Test Day'));
    test('stores emoji', () => expect(day.emoji, '🦕'));
    test('stores attractions', () => expect(day.attractions.length, 2));
    test('maxScore is sum of attraction maxScores', () =>
        expect(day.maxScore, 5),); // 2 + 3
    test('empty day has maxScore 0', () {
      const empty = Day(
          number: 99, date: '', title: '', emoji: '', attractions: [],);
      expect(empty.maxScore, 0);
    });
  });
}
