import 'package:flutter/material.dart';
import 'package:quiz_game/src/model/options.dart';

class Question extends ChangeNotifier {
  final int id;
  final String description;
  final String? difficulty;
  final String? topic;
  final String? solution;
  final List<Option> options;

  bool _isAnswered;
  bool _solutionChecked;

  Question({
    required this.id,
    required this.description,
    this.difficulty,
    this.topic,
    this.solution,
    required this.options,
    bool isAnswered = false,
    bool solutionChecked = false,
  })  : _isAnswered = isAnswered,
        _solutionChecked = solutionChecked;

  bool get isAnswered => _isAnswered;
  bool get solutionChecked => _solutionChecked;

  // Reset the state of all options when moving to the next question
  void resetOptionsState() {
    for (var option in options) {
      option.resetState();
    }
    _isAnswered = false;
    _solutionChecked = false;
    notifyListeners();
  }

  // Set answer status
  void setAnswerStatus(bool status) {
    if (_isAnswered != status) {
      _isAnswered = status;
      notifyListeners();
    }
  }

  // Set solution status
  void setSolutionStatus(bool status) {
    if (_solutionChecked != status) {
      _solutionChecked = status;
      notifyListeners();
    }
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      description: json['description'],
      difficulty: json['difficulty'],
      topic: json['topic'],
      solution: json['detailed_solution'],
      options: (json['options'] as List)
          .map((option) => Option.fromJson(option))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'difficulty': difficulty,
      'topic': topic,
      'solution': solution,
      'options': options.map((option) => option.toJson()).toList(),
    };
  }
}
