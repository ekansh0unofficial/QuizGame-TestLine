import 'package:flutter/material.dart';
import 'package:quiz_game/src/helper/backend/shared_pref_helper.dart';
import 'package:quiz_game/src/pages/quiz_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.initialise();
  runApp(QuizGameApp());
}

class QuizGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: QuizHomePage(),
    );
  }
}
