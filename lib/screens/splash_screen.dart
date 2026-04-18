import 'package:flutter/material.dart';
import '../services/score_service.dart';
import 'home_screen.dart';
import 'player_select_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkPlayer();
  }

  Future<void> _checkPlayer() async {
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    final player = await ScoreService.getPlayer();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => player != null
            ? HomeScreen(playerName: player)
            : const PlayerSelectScreen(),
      ),
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
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🇬🇧', style: TextStyle(fontSize: 80)),
              SizedBox(height: 20),
              Text(
                'LONDON QUEST',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFDC143C),
                  letterSpacing: 4,
                ),
              ),
              SizedBox(height: 40),
              CircularProgressIndicator(color: Color(0xFFDC143C)),
            ],
          ),
        ),
      ),
    );
  }
}
