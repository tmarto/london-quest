import 'package:flutter/material.dart';
import '../data/trip_data.dart';
import '../models/day.dart';
import '../services/score_service.dart';
import 'day_screen.dart';
import 'player_select_screen.dart';

class HomeScreen extends StatefulWidget {
  final String playerName;
  const HomeScreen({super.key, required this.playerName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _totalScore = 0;
  List<int> _dayScores = List.filled(4, 0);
  final int _totalMax = ScoreService.getTotalMaxScore();

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  Future<void> _loadScores() async {
    final total = await ScoreService.getTotalScore(widget.playerName);
    final dayScores = await Future.wait(
      tripDays.map((d) => ScoreService.getDayScore(widget.playerName, d.number)),
    );
    if (!mounted) return;
    setState(() {
      _totalScore = total;
      _dayScores = dayScores;
    });
  }

  String get _displayName {
    if (widget.playerName == 'Ines') return 'Inês';
    if (widget.playerName == 'Ana') return 'Ana';
    return 'Pedro';
  }

  String get _emoji {
    if (widget.playerName == 'Ines') return '👧';
    if (widget.playerName == 'Ana') return '👩';
    return '👦';
  }

  Future<void> _changePlayer() async {
    await ScoreService.clearPlayer();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const PlayerSelectScreen()),
      (route) => false,
    );
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
              // Header bar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 8, 0),
                child: Row(
                  children: [
                    Text(_emoji, style: const TextStyle(fontSize: 32)),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _displayName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'London Quest 🇬🇧',
                          style: TextStyle(color: Colors.white38, fontSize: 12),
                        ),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: _changePlayer,
                      child: const Text(
                        'Mudar jogador',
                        style: TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              // Total score card
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B0000), Color(0xFFDC143C)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Text('🏆', style: TextStyle(fontSize: 38)),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pontos Totais da Viagem',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$_totalScore / $_totalMax',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 52,
                        height: 52,
                        child: CircularProgressIndicator(
                          value: _totalMax > 0 ? _totalScore / _totalMax : 0,
                          backgroundColor: Colors.white24,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 5,
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
                    'Os teus dias em Londres',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  itemCount: tripDays.length,
                  itemBuilder: (ctx, i) {
                    final day = tripDays[i];
                    final score = i < _dayScores.length ? _dayScores[i] : 0;
                    return _DayCard(
                      day: day,
                      score: score,
                      onTap: () => Navigator.push(
                        ctx,
                        MaterialPageRoute(
                          builder: (_) => DayScreen(
                            day: day,
                            playerName: widget.playerName,
                          ),
                        ),
                      ).then((_) => _loadScores()),
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

class _DayCard extends StatelessWidget {
  final Day day;
  final int score;
  final VoidCallback onTap;

  const _DayCard({
    required this.day,
    required this.score,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final pct = day.maxScore > 0 ? score / day.maxScore : 0.0;
    final done = score >= day.maxScore && day.maxScore > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: done ? Colors.amber : Colors.white12,
            width: done ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(day.emoji, style: const TextStyle(fontSize: 36)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Dia ${day.number}',
                        style: const TextStyle(
                            color: Colors.white38, fontSize: 11),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        day.date,
                        style: const TextStyle(
                            color: Colors.white38, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    day.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: pct,
                            backgroundColor: Colors.white12,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              done ? Colors.amber : const Color(0xFFDC143C),
                            ),
                            minHeight: 5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '$score/${day.maxScore}',
                        style: const TextStyle(
                            color: Colors.white38, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${day.attractions.length} atrações',
                    style: const TextStyle(
                        color: Colors.white24, fontSize: 11),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white24, size: 20),
          ],
        ),
      ),
    );
  }
}
