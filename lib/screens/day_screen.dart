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
    final schedule = await ScoreService.getSchedule();
    final ids = schedule[widget.day.number] ??
        widget.day.attractions.map((a) => a.id).toList();
    final attractions = ids
        .map((id) => attractionById[id])
        .whereType<Attraction>()
        .toList();

    final scores = <String, int>{};
    for (final a in attractions) {
      scores[a.id] =
          await ScoreService.getAttractionScore(widget.playerName, a.id);
    }
    final dayScore = scores.values.fold(0, (sum, s) => sum + s);
    if (!mounted) return;
    setState(() {
      _attractions = attractions;
      _scores = scores;
      _dayScore = dayScore;
    });
  }

  Future<void> _confirmResetDay() async {
    // Step 1: pick whose scores to reset
    final targetPlayer = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a2e),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Resetar pontos de quem?',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        content: const Text(
          'Escolhe o jogador cujos pontos deste dia serão apagados.',
          style: TextStyle(color: Colors.white60, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar',
                style: TextStyle(color: Colors.white54),),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'Pedro'),
            child: const Text('👦 Pedro',
                style: TextStyle(color: Colors.white),),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'Ines'),
            child: const Text('👧 Inês',
                style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
    if (targetPlayer == null || !mounted) return;

    // Step 2: confirm
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a2e),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Resetar pontos de $targetPlayer?',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        content: Text(
          'Os pontos de $targetPlayer neste dia serão apagados.',
          style: const TextStyle(color: Colors.white60, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar',
                style: TextStyle(color: Colors.white54),),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Resetar',
                style: TextStyle(color: Color(0xFFDC143C)),),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await ScoreService.resetDayScores(targetPlayer, widget.day.number);
      await _loadScores();
    }
  }

  Future<void> _startQuiz(Attraction attraction) async {
    if (widget.playerName == 'Ana') {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TeachScreen(attraction: attraction),
        ),
      );
      return;
    }

    // Language selection dialog
    if (!mounted) return;
    final useEnglish = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: const Color(0xFF1a1a2e),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(attraction.emoji,
                  style: const TextStyle(fontSize: 44),),
              const SizedBox(height: 12),
              Text(
                attraction.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Escolhe o idioma do quiz',
                style: TextStyle(color: Colors.white54, fontSize: 13),
              ),
              const SizedBox(height: 20),
              // PT button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.3),),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🇵🇹', style: TextStyle(fontSize: 22)),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Português',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,),),
                          Text('pontos normais',
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 11,),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // EN button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B4B8A),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🇬🇧', style: TextStyle(fontSize: 22)),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('English',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,),),
                          Text('2× pontos!',
                              style: TextStyle(
                                  color: Colors.amber, fontSize: 11,),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (useEnglish == null || !mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(
          attraction: attraction,
          playerName: widget.playerName,
          useEnglish: useEnglish,
        ),
      ),
    );
    _loadScores();
  }

  @override
  Widget build(BuildContext context) {
    final isAna = widget.playerName == 'Ana';
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
                        style: const TextStyle(fontSize: 26),),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dia ${widget.day.number}  •  ${widget.day.date}',
                            style: const TextStyle(
                                color: Colors.white38, fontSize: 11,),
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
                    if (isAna)
                      IconButton(
                        icon: const Icon(Icons.refresh,
                            color: Colors.white38, size: 20,),
                        tooltip: 'Resetar pontos do dia',
                        onPressed: _confirmResetDay,
                      ),
                  ],
                ),
              ),
              // Day score summary
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 14,),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color:
                            const Color(0xFFDC143C).withValues(alpha: 0.4),),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '⭐ Pontos do dia',
                        style:
                            TextStyle(color: Colors.white70, fontSize: 14),
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
                      color: Colors.white.withValues(alpha: 0.55),
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
                      isTeacher: isAna,
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
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isTeacher
                ? const Color(0xFF4CAF50).withValues(alpha: 0.5)
                : (isPerfect ? Colors.amber : Colors.white12),
            width: isTeacher ? 1 : (isPerfect ? 2 : 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 88,
              height: 96,
              decoration: BoxDecoration(
                color: attraction.color,
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(15),),
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
                                horizontal: 8, vertical: 3,),
                            decoration: BoxDecoration(
                              color: isPerfect
                                  ? Colors.amber.withValues(alpha: 0.2)
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
                              horizontal: 8, vertical: 3,),
                          decoration: BoxDecoration(
                            color: isTeacher
                                ? const Color(0xFF4CAF50)
                                    .withValues(alpha: 0.2)
                                : const Color(0xFFDC143C)
                                    .withValues(alpha: 0.2),
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
