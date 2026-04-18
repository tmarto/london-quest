class Question {
  final String text;
  final List<String> options;
  final int correctIndex;
  final String funFact;
  final String? imageUrl;

  const Question({
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.funFact,
    this.imageUrl,
  });
}
