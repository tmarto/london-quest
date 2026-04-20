import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/attraction.dart';
import '../models/question.dart';
import '../services/score_service.dart';
import '../widgets/attraction_image.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final Attraction attraction;
  final String playerName;
  final bool useEnglish;

  const QuizScreen({
    super.key,
    required this.attraction,
    required this.playerName,
    this.useEnglish = false,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Question> _questions;
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedAnswer;
  bool _answered = false;
  int _timeLeft = 20;
  int _questionDuration = 20;
  Timer? _timer;
  late List<String> _shuffledOptions;
  late int _shuffledCorrectIndex;

  void _shuffleQuestion() {
    final q = _questions[_currentIndex];
    final opts = q.localOptions(widget.useEnglish);
    final indexed = opts.asMap().entries.toList()..shuffle(Random());
    _shuffledOptions = indexed.map((e) => e.value).toList();
    _shuffledCorrectIndex =
        indexed.indexWhere((e) => e.key == q.correctIndex);
  }

  @override
  void initState() {
    super.initState();
    // Randomly pick 10 questions from the full bank each session.
    final bank = List<Question>.from(widget.attraction.questions)
      ..shuffle(Random());
    _questions = bank.take(10).toList();
    _shuffleQuestion();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _questionDuration = widget.useEnglish ? 30 : 20;
    _timeLeft = _questionDuration;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_timeLeft <= 0) {
        t.cancel();
        if (!_answered) _handleAnswer(-1);
      } else {
        setState(() => _timeLeft--);
      }
    });
  }

  void _handleAnswer(int index) {
    if (_answered) return;
    _timer?.cancel();
    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == _shuffledCorrectIndex) _score++;
    });
  }

  Future<void> _nextQuestion() async {
    if (_currentIndex >= _questions.length - 1) {
      final multiplier = widget.useEnglish ? 2 : 1;
      await ScoreService.saveAttractionScore(
          widget.playerName, widget.attraction.id, _score * multiplier,);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            attraction: widget.attraction,
            playerName: widget.playerName,
            score: _score,
            total: _questions.length,
          ),
        ),
      );
    } else {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _answered = false;
        _shuffleQuestion();
      });
      _startTimer();
    }
  }

  Color _optionColor(int index) {
    if (!_answered) return Colors.white.withValues(alpha: 0.06);
    if (index == _shuffledCorrectIndex) {
      return Colors.green.withValues(alpha: 0.25);
    }
    if (index == _selectedAnswer) return Colors.red.withValues(alpha: 0.25);
    return Colors.white.withValues(alpha: 0.04);
  }

  Color _optionBorderColor(int index) {
    if (!_answered) return Colors.white.withValues(alpha: 0.15);
    if (index == _shuffledCorrectIndex) return Colors.green;
    if (index == _selectedAnswer) return Colors.red;
    return Colors.white.withValues(alpha: 0.08);
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_currentIndex];
    final timerColor = _timeLeft <= 5 ? Colors.red : Colors.white70;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.attraction.emoji,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.attraction.name,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13,),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (widget.useEnglish) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2,),
                            decoration: BoxDecoration(
                              color: Colors.amber.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              '🇬🇧 2×',
                              style: TextStyle(
                                  color: Colors.amber, fontSize: 11,),
                            ),
                          ),
                        ],
                      ],
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6,),
                      decoration: BoxDecoration(
                        color: _timeLeft <= 5
                            ? Colors.red.withValues(alpha: 0.2)
                            : Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              _timeLeft <= 5 ? Colors.red : Colors.white24,
                        ),
                      ),
                      child: Text(
                        '⏱ $_timeLeft s',
                        style: TextStyle(
                          color: timerColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      '⭐ $_score',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Question progress bar
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: (_currentIndex + 1) / _questions.length,
                          backgroundColor: Colors.white12,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFDC143C),
                          ),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${_currentIndex + 1}/${_questions.length}',
                      style: const TextStyle(
                          color: Colors.white38, fontSize: 13,),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Timer progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _answered ? 0 : _timeLeft / _questionDuration,
                    backgroundColor: Colors.white12,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _timeLeft <= 5
                          ? Colors.red
                          : _timeLeft <= (_questionDuration * 0.4).ceil()
                              ? Colors.orange
                              : Colors.greenAccent,
                    ),
                    minHeight: 5,
                  ),
                ),
                const SizedBox(height: 12),
                // Scrollable body
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                // Attraction image
                AttractionImage(
                  imageUrl: widget.attraction.imageUrl,
                  fallbackEmoji: widget.attraction.emoji,
                  height: 160,
                ),
                const SizedBox(height: 14),
                // Question card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Text(
                    q.localText(widget.useEnglish),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      height: 1.45,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Answer options
                ...List.generate(_shuffledOptions.length, (i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: _answered ? null : () => _handleAnswer(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: _optionColor(i),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: _optionBorderColor(i)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  ['A', 'B', 'C', 'D'][i],
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _shuffledOptions[i],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            if (_answered && i == _shuffledCorrectIndex)
                              const Text('✅',
                                  style: TextStyle(fontSize: 18),),
                            if (_answered &&
                                i == _selectedAnswer &&
                                i != _shuffledCorrectIndex)
                              const Text('❌',
                                  style: TextStyle(fontSize: 18),),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                // Fun fact + next button
                if (_answered) ...[
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.amber.withValues(alpha: 0.35),),
                    ),
                    child: Text(
                      '💡 ${q.localFunFact(widget.useEnglish)}',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC143C),
                        padding:
                            const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentIndex >= _questions.length - 1
                            ? 'Ver Resultado 🏆'
                            : 'Próxima ➡️',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
