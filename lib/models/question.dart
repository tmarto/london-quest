class Question {
  final String text;
  final String? textEn;
  final List<String> options;
  final List<String>? optionsEn;
  final int correctIndex;
  final String funFact;
  final String? funFactEn;
  final String? imageUrl;

  const Question({
    required this.text,
    this.textEn,
    required this.options,
    this.optionsEn,
    required this.correctIndex,
    required this.funFact,
    this.funFactEn,
    this.imageUrl,
  });

  String localText(bool en) => (en && textEn != null) ? textEn! : text;
  List<String> localOptions(bool en) =>
      (en && optionsEn != null) ? optionsEn! : options;
  String localFunFact(bool en) =>
      (en && funFactEn != null) ? funFactEn! : funFact;
}
