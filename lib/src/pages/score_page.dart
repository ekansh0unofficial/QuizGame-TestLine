import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:quiz_game/main.dart';
import 'dart:math';

import 'package:quiz_game/src/helper/backend/shared_pref_helper.dart';
import 'package:quiz_game/src/pages/quiz_home_page.dart';

class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  late ConfettiController _confettiController;

  Future<int> getScore() async {
    // Get the score and convert it to an integer
    double score = await SharedPrefHelper.getScore();
    return score.toInt(); // Remove the decimal part
  }

  @override
  void initState() {
    super.initState();
    // Initialize the confetti controller
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => QuizHomePage()));
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.jpg', // Your background image (bg.jpg)
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2, // Vertical direction
              blastDirectionality:
                  BlastDirectionality.explosive, // Spread in all directions
              emissionFrequency: 0.05, // How often particles are emitted
              numberOfParticles: 50, // Number of particles at a time
              gravity: 0.1, // Gravity of the particles
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow,
              ], // Particle colors
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: getScore(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("E R R O R");
                    } else {
                      // Display the score as an integer
                      return Column(
                        children: [
                          Text(
                            snapshot.data.toString(),
                            style: TextStyle(
                                fontSize: 60, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            snapshot.data! > 10 ? 'Congratulations!' : 'Oops',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            snapshot.data! > 10
                                ? 'You have successfully completed the quiz!'
                                : " You can do better",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          // Add the confetti widget
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2, // Vertical direction
              blastDirectionality:
                  BlastDirectionality.explosive, // Spread in all directions
              emissionFrequency: 0.05, // How often particles are emitted
              numberOfParticles: 20, // Number of particles at a time
              gravity: 0.1, // Gravity of the particles
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow,
              ], // Particle colors
            ),
          ),
        ],
      ),
    );
  }
}
