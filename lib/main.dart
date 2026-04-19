import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initCrashlytics();
  runApp(const LondonQuestApp());
}

/// Initialises Firebase + Crashlytics.
/// Fails silently when [firebase_options.dart] contains placeholder values so
/// the app still runs during development before a real Firebase project is set up.
Future<void> _initCrashlytics() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Forward Flutter framework errors to Crashlytics
    FlutterError.onError =
        FirebaseCrashlytics.instance.recordFlutterFatalError;
    // Forward Dart async errors that escape the widget tree
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } catch (_) {
    // Firebase not yet configured — run without crash reporting.
    // To enable: run `flutterfire configure` and replace lib/firebase_options.dart
  }
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
