import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String _scoreKey = 'score';
  static const String _highScoreKey = 'highscore';
  static const String _positiveKey = 'positive';
  static const String _negativeKey = 'negative';

  static late SharedPreferences _prefs;

  /// Initialize SharedPreferences and set default values if not present
  static Future<void> initialise() async {
    _prefs = await SharedPreferences.getInstance();
    if (!_prefs.containsKey(_scoreKey)) {
      await _prefs.setDouble(_scoreKey, 0.0);
    }
    if (!_prefs.containsKey(_highScoreKey)) {
      await _prefs.setDouble(_highScoreKey, 0.0);
    }
    if (!_prefs.containsKey(_positiveKey)) {
      await _prefs.setDouble(_positiveKey, 4.0);
    }
    if (!_prefs.containsKey(_negativeKey)) {
      await _prefs.setDouble(_negativeKey, -1.0);
    }
  }

  /// Update the high score if the current score is greater
  static Future<void> setHighScore() async {
    double currentScore = _prefs.getDouble(_scoreKey) ?? 0.0;
    double highScore = _prefs.getDouble(_highScoreKey) ?? 0.0;
    if (currentScore > highScore) {
      await _prefs.setDouble(_highScoreKey, currentScore);
    }
  }

  /// Retrieve the high score
  static double getHighScore() {
    return _prefs.getDouble(_highScoreKey) ?? 0.0;
  }

  /// Increment the score by the positive value
  static Future<void> incScore() async {
    double currentScore = _prefs.getDouble(_scoreKey) ?? 0.0;
    double positiveValue = _prefs.getDouble(_positiveKey) ?? 4.0;
    await _prefs.setDouble(_scoreKey, currentScore + positiveValue);
  }

  /// Decrement the score by the negative value
  static Future<void> decScore() async {
    double currentScore = _prefs.getDouble(_scoreKey) ?? 0.0;
    double negativeValue = _prefs.getDouble(_negativeKey) ?? -1.0;
    await _prefs.setDouble(_scoreKey, currentScore + negativeValue);
  }

  /// Retrieve the current score
  static double getScore() {
    return _prefs.getDouble(_scoreKey) ?? 0.0;
  }

  static Future<void> setScore() async {
    await _prefs.setDouble(_scoreKey, 0);
  }

  /// Set a new positive increment value
  static Future<void> setPositive(double value) async {
    await _prefs.setDouble(_positiveKey, value);
  }

  /// Set a new negative decrement value
  static Future<void> setNegative(double value) async {
    await _prefs.setDouble(_negativeKey, value);
  }
}
