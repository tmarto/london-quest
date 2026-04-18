import 'package:flutter/material.dart';
import '../models/attraction.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatefulWidget {
  final Attraction attraction;
  final String playerName;
  final int score;
  final int total;

  const ResultScreen({
    super.key,
    required this.attraction,
    required this.playerName,
    required this.score,
    required this.total,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.elasticOut,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  String get _emoji {
    final pct = widget.score / widget.total;
    if (pct == 1.0) return '🏆';
    if (pct >= 0.8) return '🌟';
    if (pct >= 0.6) return '😄';
    if (pct >= 0.4) return '👍';
    return '💪';
  }

  String get _message {
    final pct = widget.score / widget.total;
    final name = widget.playerName == 'Ines' ? 'Inês' : 'Pedro';
    if (pct == 1.0) return 'Perfeito, $name!\nConheces tudo sobre ${widget.attraction.name}!';
    if (pct >= 0.8) return 'Muito bem, $name!\nQuase perfeito!';
    if (pct >= 0.6) return 'Bom esforço, $name!\nEstás a aprender!';
    if (pct >= 0.4) return 'Continua, $name!\nPratica mais antes da viagem!';
    return 'Não desistas, $name!\nTenta outra vez!';
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
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Attraction header
                  Text(
                    widget.attraction.emoji,
                    style: const TextStyle(fontSize: 48),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.attraction.name,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ScaleTransition(
                    scale: _scaleAnim,
                    child: Text(
                      _emoji,
                      style: const TextStyle(fontSize: 80),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ScaleTransition(
                    scale: _scaleAnim,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFFDC143C),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${widget.score}',
                            style: const TextStyle(
                              color: Color(0xFFDC143C),
                              fontSize: 72,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          Text(
                            'de ${widget.total} certas',
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QuizScreen(
                            attraction: widget.attraction,
                            playerName: widget.playerName,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC143C),
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Tentar de Novo 🔄',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white24),
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Voltar às Atrações ⬅️',
                        style:
                            TextStyle(color: Colors.white60, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
