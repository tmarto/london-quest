import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/trip_data.dart';

class ScoreService {
  static const _playerKey   = 'current_player';
  static const _scheduleKey = 'custom_schedule';

  // ── Player ────────────────────────────────────────────────────────────────

  static Future<void> savePlayer(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_playerKey, name);
  }

  static Future<String?> getPlayer() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_playerKey);
  }

  static Future<void> clearPlayer() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_playerKey);
  }

  // ── Schedule ──────────────────────────────────────────────────────────────

  static Future<Map<int, List<String>>> getSchedule() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_scheduleKey);
    if (json == null) return defaultSchedule;
    try {
      final Map<String, dynamic> decoded = jsonDecode(json);
      return decoded.map(
        (k, v) => MapEntry(int.parse(k), List<String>.from(v)),
      );
    } catch (_) {
      return defaultSchedule;
    }
  }

  static Future<void> saveSchedule(Map<int, List<String>> schedule) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded =
        jsonEncode(schedule.map((k, v) => MapEntry(k.toString(), v)));
    await prefs.setString(_scheduleKey, encoded);
  }

  static Future<void> resetSchedule() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_scheduleKey);
  }

  // ── Scores ────────────────────────────────────────────────────────────────

  static Future<void> saveAttractionScore(
      String player, String attractionId, int score,) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'score_${player}_$attractionId';
    final current = prefs.getInt(key) ?? 0;
    if (score > current) await prefs.setInt(key, score);
  }

  static Future<int> getAttractionScore(
      String player, String attractionId,) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('score_${player}_$attractionId') ?? 0;
  }

  static Future<int> getDayScore(String player, int dayNumber) async {
    final prefs = await SharedPreferences.getInstance();
    final schedule = await getSchedule();
    final ids = schedule[dayNumber] ?? [];
    int total = 0;
    for (final id in ids) {
      total += prefs.getInt('score_${player}_$id') ?? 0;
    }
    return total;
  }

  static Future<int> getTotalScore(String player) async {
    final prefs = await SharedPreferences.getInstance();
    int total = 0;
    for (final a in attractionById.values) {
      total += prefs.getInt('score_${player}_${a.id}') ?? 0;
    }
    return total;
  }

  static int getTotalMaxScore() =>
      attractionById.values.fold(0, (sum, a) => sum + a.maxScore);

  // ── Reset ─────────────────────────────────────────────────────────────────

  static Future<void> resetDayScores(String player, int dayNumber) async {
    final prefs = await SharedPreferences.getInstance();
    final schedule = await getSchedule();
    final ids = schedule[dayNumber] ?? [];
    for (final id in ids) {
      await prefs.remove('score_${player}_$id');
    }
  }
}
