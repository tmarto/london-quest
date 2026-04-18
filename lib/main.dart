import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const LondonQuestApp());
}

class LondonQuestApp extends StatelessWidget {
  const LondonQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'London Quest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFDC143C),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
