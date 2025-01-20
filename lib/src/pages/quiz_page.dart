import 'package:flutter/material.dart';
import 'package:quiz_game/src/helper/backend/quiz_game_api.dart';
import 'package:quiz_game/src/helper/backend/shared_pref_helper.dart';
import 'package:quiz_game/src/model/quiz_data.dart';
import 'package:quiz_game/src/pages/question_page.dart';
import 'package:quiz_game/src/pages/score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<QuizData> _quizDataFuture;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _quizDataFuture = QuizGameApi().fetchQuiz();
  }

  // Method to go to the next question
  void goToNextQuestion(int totalQuestions) {
    setState(() {
      index++;
      // Navigate to ScorePage if all questions are answered
      if (index >= totalQuestions) {
        navigateToScorePage();
      } else {
        resetOptionsState();
      }
    });
  }

  // Method to go to the previous question
  void goToPreviousQuestion() {
    if (index > 0) {
      setState(() {
        index--;
        resetOptionsState();
      });
    }
  }

  // Reset the state of options for the new question
  void resetOptionsState() {
    _quizDataFuture.then((quizData) {
      final questions = quizData.questions;
      for (var option in questions[index].options) {
        option.resetState();
      }
    });
  }

  // Navigate to ScorePage
  void navigateToScorePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ScorePage()),
    );
  }

  // Fetch the current score from SharedPreferences
  Future<double> getScore() async {
    return await SharedPrefHelper.getScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Game'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: FutureBuilder<double>(
              future: getScore(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Text(
                    'Score: ${snapshot.data}',
                    style: TextStyle(fontSize: 18),
                  );
                } else {
                  return const Text('Score: 0');
                }
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<QuizData>(
        future: _quizDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            SharedPrefHelper.setPositive(snapshot.data!.correct);
            SharedPrefHelper.setNegative(snapshot.data!.incorrect);
            final questions = snapshot.data!.questions;
            return QuestionPage(
              questions: questions,
              index: index,
              onNext: () => goToNextQuestion(questions.length),
              onPrev: goToPreviousQuestion,
            );
          } else {
            return const Center(child: Text('No quiz data available.'));
          }
        },
      ),
    );
  }
}
