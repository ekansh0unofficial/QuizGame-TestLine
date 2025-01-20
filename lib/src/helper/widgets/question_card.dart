import 'package:flutter/material.dart';
import 'package:quiz_game/src/helper/widgets/option_card.dart';
import 'package:quiz_game/src/model/question.dart';

class QuestionCard extends StatelessWidget {
  final Question question;

  QuestionCard({required this.question});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: _buildContainerDecoration(),
        child: Column(
          children: [
            _buildQuestionDescription(),
            ..._buildOptionCards(),
            _buildSpacing(),
          ],
        ),
      ),
    );
  }

  // Builds the decoration for the container
  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: const Color.fromARGB(255, 216, 243, 255),
      borderRadius: BorderRadius.all(Radius.circular(24)),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    );
  }

  // Builds the question description text
  Padding _buildQuestionDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Text(
        question.description,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  // Builds a list of option cards
  List<Widget> _buildOptionCards() {
    return question.options.map((option) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
        child: OptionCard(
          option: option,
          isAnswered: question.isAnswered,
          onAnswered: (bool answer) {
            question.setAnswerStatus(answer);
          },
        ),
      );
    }).toList();
  }

  // Adds spacing at the bottom
  SizedBox _buildSpacing() {
    return SizedBox(
      height: 20,
    );
  }
}
