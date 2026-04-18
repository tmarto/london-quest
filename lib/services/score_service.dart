import 'package:shared_preferences/shared_preferences.dart';
import '../data/trip_data.dart';

class ScoreService {
  static const _playerKey = 'current_player';

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

  static Future<void> saveAttractionScore(
      String player, String attractionId, int score) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'score_${player}_$attractionId';
    final current = prefs.getInt(key) ?? 0;
    if (score > current) await prefs.setInt(key, score);
  }

  static Future<int> getAttractionScore(
      String player, String attractionId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('score_${player}_$attractionId') ?? 0;
  }

  static Future<int> getDayScore(String player, int dayNumber) async {
    final prefs = await SharedPreferences.getInstance();
    final day = tripDays.firstWhere((d) => d.number == dayNumber);
    int total = 0;
    for (final a in day.attractions) {
      total += prefs.getInt('score_${player}_${a.id}') ?? 0;
    }
    return total;
  }

  static Future<int> getTotalScore(String player) async {
    final prefs = await SharedPreferences.getInstance();
    int total = 0;
    for (final day in tripDays) {
      for (final a in day.attractions) {
        total += prefs.getInt('score_${player}_${a.id}') ?? 0;
      }
    }
    return total;
  }

  static int getTotalMaxScore() =>
      tripDays.fold(0, (sum, d) => sum + d.maxScore);
}
