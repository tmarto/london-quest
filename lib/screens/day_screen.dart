import 'package:flutter/material.dart';
import '../data/trip_data.dart';
import '../models/attraction.dart';
import '../models/day.dart';
import '../services/score_service.dart';
import 'quiz_screen.dart';
import 'teach_screen.dart';

class DayScreen extends StatefulWidget {
  final Day day;
  final String playerName;

  const DayScreen({super.key, required this.day, required this.playerName});

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  Map<String, int> _scores = {};
  int _dayScore = 0;
  List<Attraction> _attractions = [];

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  Future<void> _loadScores() async {
    // Load custom schedule for this day
    final schedule = await ScoreService.getSchedule();
    final ids = schedule[widget.day.number] ??
        widget.day.attractions.map((a) => a.id).toList();
    final attractions = ids
        .map((id) => attractionById[id])
        .whereType<Attraction>()
        .toList();

    final scores = <String, int>{};
    for (final a in attractions) {
      scores[a.id] = await ScoreService.getAttractionScore(widget.playerName, a.id);
    }
    final dayScore = scores.values.fold(0, (sum, s) => sum + s);
    if (!mounted) return;
    setState(() {
      _attractions = attractions;
      _scores = scores;
      _dayScore = dayScore;
    });
  }

  void _startQuiz(Attraction attraction) {
    if (widget.playerName == 'Ana') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TeachScreen(attraction: attraction),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => QuizScreen(
            attraction: attraction,
            playerName: widget.playerName,
          ),
        ),
      ).then((_) => _loadScores());
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 8, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white70),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(widget.day.emoji,
                        style: const TextStyle(fontSize: 26)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dia ${widget.day.number}  •  ${widget.day.date}',
                            style: const TextStyle(
                                color: Colors.white38, fontSize: 11),
                          ),
                          Text(
                            widget.day.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Day score summary
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: const Color(0xFFDC143C).withOpacity(0.4)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '⭐ Pontos do dia',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      Text(
                        '$_dayScore / ${_attractions.fold(0, (s, a) => s + a.maxScore)}',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Atrações do dia',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.55),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  itemCount: _attractions.length,
                  itemBuilder: (ctx, i) {
                    final a = _attractions[i];
                    final score = _scores[a.id] ?? 0;
                    return _AttractionCard(
                      attraction: a,
                      score: score,
                      isTeacher: widget.playerName == 'Ana',
                      onTap: () => _startQuiz(a),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AttractionCard extends StatelessWidget {
  final Attraction attraction;
  final int score;
  final bool isTeacher;
  final VoidCallback onTap;

  const _AttractionCard({
    required this.attraction,
    required this.score,
    required this.onTap,
    this.isTeacher = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasPlayed = score > 0;
    final maxScore = attraction.maxScore;
    final isPerfect = score >= maxScore;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isTeacher
                ? const Color(0xFF4CAF50).withOpacity(0.5)
                : (isPerfect ? Colors.amber : Colors.white12),
            width: isTeacher ? 1 : (isPerfect ? 2 : 1),
          ),
        ),
        child: Row(
          children: [
            // Attraction image panel
            Container(
              width: 88,
              height: 96,
              decoration: BoxDecoration(
                color: attraction.color,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(15)),
              ),
              child: Center(
                child: Text(
                  attraction.emoji,
                  style: const TextStyle(fontSize: 42),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attraction.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      attraction.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (hasPlayed) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isPerfect
                                  ? Colors.amber.withOpacity(0.2)
                                  : Colors.white10,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '$score/$maxScore pts',
                              style: TextStyle(
                                color: isPerfect
                                    ? Colors.amber
                                    : Colors.white60,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isTeacher
                                ? const Color(0xFF4CAF50).withOpacity(0.2)
                                : const Color(0xFFDC143C).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isTeacher
                                ? '📖 Ensinar'
                                : (hasPlayed ? '🔄 Repetir' : '▶ Fazer Quiz'),
                            style: TextStyle(
                              color: isTeacher
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFFDC143C),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
