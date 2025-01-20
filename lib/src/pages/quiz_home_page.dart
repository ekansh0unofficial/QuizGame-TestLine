import 'package:flutter/material.dart';
import 'package:quiz_game/src/helper/backend/shared_pref_helper.dart';
import 'package:quiz_game/src/helper/widgets/game_button.dart';
import 'package:quiz_game/src/pages/high_score_page.dart';
import 'package:quiz_game/src/pages/quiz_page.dart';

class QuizHomePage extends StatelessWidget {
  const QuizHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              //Quiz Game Logo (or Name)
              Padding(
                padding: const EdgeInsets.all(60.0),
                child: Image.asset('assets/images/quizlogo.png'),
              ),

              //Play/Start Button
              GameButton(
                  size: 100,
                  color: Colors.purple.shade400,
                  onPressed: () {
                    SharedPrefHelper.setScore();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => QuizPage()));
                  },
                  child: const Text("P L A Y",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Luckiest Guy'))),
              //Highscore
              SizedBox(
                height: 18,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HighScorePage()));
                  },
                  child: Text(
                    'H i g h s c o r e ',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ))
            ])),
      ]),
    );
  }
}
