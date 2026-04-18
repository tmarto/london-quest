import 'attraction.dart';

class Day {
  final int number;
  final String date;
  final String title;
  final String emoji;
  final List<Attraction> attractions;

  const Day({
    required this.number,
    required this.date,
    required this.title,
    required this.emoji,
    required this.attractions,
  });

  int get maxScore => attractions.fold(0, (sum, a) => sum + a.maxScore);
}
