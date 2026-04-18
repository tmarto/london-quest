import 'package:flutter/material.dart';
import '../services/score_service.dart';
import 'home_screen.dart';

class PlayerSelectScreen extends StatelessWidget {
  const PlayerSelectScreen({super.key});

  Future<void> _selectPlayer(BuildContext context, String player) async {
    await ScoreService.savePlayer(player);
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen(playerName: player)),
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🇬🇧', style: TextStyle(fontSize: 72)),
                  const SizedBox(height: 16),
                  const Text(
                    'LONDON QUEST',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFDC143C),
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A tua aventura começa aqui!',
                    style: TextStyle(color: Colors.white60, fontSize: 15),
                  ),
                  const SizedBox(height: 60),
                  const Text(
                    'Quem és tu?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: _PlayerButton(
                          name: 'Inês',
                          emoji: '👧',
                          onTap: () => _selectPlayer(context, 'Ines'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _PlayerButton(
                          name: 'Pedro',
                          emoji: '👦',
                          onTap: () => _selectPlayer(context, 'Pedro'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _PlayerButton(
                          name: 'Ana',
                          emoji: '👩',
                          label: 'Ensinar',
                          onTap: () => _selectPlayer(context, 'Ana'),
                        ),
                      ),
                    ],
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

class _PlayerButton extends StatelessWidget {
  final String name;
  final String emoji;
  final String? label;
  final VoidCallback onTap;

  const _PlayerButton({
    required this.name,
    required this.emoji,
    required this.onTap,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFDC143C), width: 2),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 44)),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (label != null) ...[
              const SizedBox(height: 4),
              Text(
                label!,
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 11,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
