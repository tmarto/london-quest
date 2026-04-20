import 'package:flutter/material.dart';
import 'question.dart';

class Attraction {
  final String id;
  final String name;
  final String emoji;
  final Color color;
  final String description;
  final String imageUrl;
  final List<Question> questions;

  const Attraction({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
    required this.description,
    required this.imageUrl,
    required this.questions,
  });

  /// Quiz always draws 10 questions regardless of bank size.
  int get maxScore => 10;
}
