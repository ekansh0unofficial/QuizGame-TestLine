import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/src/helper/widgets/game_button.dart';
import 'package:quiz_game/src/helper/widgets/question_card.dart';
import 'package:quiz_game/src/helper/widgets/solution_card.dart';
import 'package:quiz_game/src/model/question.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({
    super.key,
    required this.questions,
    required this.index,
    required this.onNext,
    required this.onPrev,
  });

  final List<Question> questions;
  final int index;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Question>.value(
      value: widget.questions[widget.index],
      child: Consumer<Question>(
        builder: (context, question, child) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.grey.shade300,
              child: Column(
                children: [
                  _buildQuestionCard(question),
                  _buildNavigationButtons(context, question),
                  _buildSolutionCard(question),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuestionCard(Question question) {
    return QuestionCard(
      question: question,
    );
  }

  Widget _buildNavigationButtons(BuildContext context, Question question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GameButton(
            onPressed: widget.onPrev,
            color: Colors.amber.shade100,
            size: 40,
            child: const Text('P R E V'),
          ),
          GameButton(
            onPressed: () {
              if (!question.isAnswered) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Attempt the Question First'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                question.setSolutionStatus(true);
              }
            },
            color: Colors.white,
            size: 40,
            child: const Text('Solution?'),
          ),
          GameButton(
            onPressed: () {
              if (question.isAnswered) {
                widget.onNext();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Attempt the Question First'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            color: Colors.green.shade100,
            size: 40,
            child: const Text('N E X T'),
          ),
        ],
      ),
    );
  }

  Widget _buildSolutionCard(Question question) {
    if (question.isAnswered && question.solutionChecked) {
      return SolutionCard(question: question);
    } else {
      return Container(
        height: 1000,
      );
    }
  }
}
