import 'package:flutter/material.dart';
import 'package:quiz_game/src/model/question.dart';

class SolutionCard extends StatelessWidget {
  const SolutionCard({super.key, required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 195, 161, 255),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12),
            child: Text(
              question.solution ?? 'No solution Avialable',
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          )),
    );
  }
}
