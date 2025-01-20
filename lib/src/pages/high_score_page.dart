import 'package:flutter/material.dart';
import 'package:quiz_game/src/helper/backend/shared_pref_helper.dart';
import 'package:quiz_game/src/pages/quiz_home_page.dart';

class HighScorePage extends StatefulWidget {
  @override
  _HighScorePageState createState() => _HighScorePageState();
}

class _HighScorePageState extends State<HighScorePage> {
  Future<int> getScore() async {
    // Get the score and convert it to an integer
    double score = await SharedPrefHelper.getScore();
    return score.toInt(); // Remove the decimal part
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('H I G H S C O R E '),
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
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.jpg', // Your background image (bg.jpg)
              fit: BoxFit.cover,
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
                            snapshot.data! >= 50 ? 'Amazing!' : 'Great Job!',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            snapshot.data! >= 50
                                ? 'You have achieved a high score! Keep it up!'
                                : "You’re doing great, aim for a higher score!",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 16),
                          snapshot.data! >= 50
                              ? Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 40,
                                )
                              : Container(),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
