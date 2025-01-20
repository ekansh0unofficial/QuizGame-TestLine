import './question.dart';

class QuizData {
  final int id;
  final String? title;
  final String? description;
  final String topic;
  final String? time;
  final double correct;
  final double incorrect;
  final List<Question> questions;

  QuizData(this.description, this.time, this.title,
      {required this.id,
      required this.questions,
      required this.topic,
      this.correct = 4,
      this.incorrect = -1});

  factory QuizData.fromJson(Map<String, dynamic> json) {
    return QuizData(
      json['description'] as String?,
      json['time'] as String?,
      json['title'] as String?,
      id: json['id'] as int,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      topic: json['topic'] as String,
      correct: double.parse(json['correct_answer_marks']),
      incorrect: -(double.parse(json['negative_marks'])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'topic': topic,
      'time': time,
      'correct': correct,
      'incorrect': incorrect,
      'questions': questions.map((e) => e.toJson()).toList(),
    };
  }
}
