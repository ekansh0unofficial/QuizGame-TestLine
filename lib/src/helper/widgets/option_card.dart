import 'package:flutter/material.dart';
import 'package:quiz_game/src/helper/backend/shared_pref_helper.dart';
import 'package:quiz_game/src/model/options.dart';

class OptionCard extends StatefulWidget {
  final Option option;
  final Function(bool) onAnswered;
  bool isAnswered;

  OptionCard({
    required this.option,
    required this.onAnswered,
    required this.isAnswered,
  });

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  Color cardColor = Colors.blue.shade100;
  IconData icon = Icons.arrow_right_sharp;

  Color getDarkerShade(Color color) {
    HSLColor hsl = HSLColor.fromColor(color);
    HSLColor darkerHsl =
        hsl.withLightness((hsl.lightness - 0.2).clamp(0.0, 1.0));
    return darkerHsl.toColor();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isAnswered) {
          setState(() {
            widget.option.isSelected = true; // Mark the option as selected

            if (widget.option.isCorrect) {
              cardColor = Colors.green.shade300;
              icon = Icons.done;
              SharedPrefHelper.incScore();
            } else {
              cardColor = Colors.red.shade300;
              icon = Icons.close;
              SharedPrefHelper.decScore();
            }

            widget
                .onAnswered(true); // Notify that the question has been answered
          });
        }
      },
      child: card(context),
    );
  }

  Widget card(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: widget.option.isSelected
            ? cardColor
            : Colors.blue.shade100, // Change color only if selected
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: Border.all(
            color: widget.option.isSelected
                ? getDarkerShade(cardColor)
                : getDarkerShade(Colors.blue.shade100),
            width: 1,
            strokeAlign: -0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 18),
          Icon(
            widget.option.isSelected ? icon : Icons.arrow_right_sharp,
            color: widget.option.isSelected
                ? getDarkerShade(cardColor)
                : getDarkerShade(Colors.blue.shade100),
          ),
          SizedBox(width: 12),
          Text(
            widget.option.description,
          ),
        ],
      ),
    );
  }
}
