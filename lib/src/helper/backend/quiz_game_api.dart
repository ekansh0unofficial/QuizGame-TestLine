import 'dart:convert';
import 'package:quiz_game/src/model/quiz_data.dart';
import 'package:http/http.dart' as http;

class QuizGameApi {
  QuizGameApi();

  String baseUrl = 'https://api.jsonserve.com/Uw5CrX';

  Future<QuizData> fetchQuiz() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // Safety check to ensure data returned is not null
        if (jsonResponse == null) {
          throw Exception('API returned null data');
        }

        return QuizData.fromJson(jsonResponse);
      } else {
        throw Exception(
            'Failed to fetch API with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching quiz data: $e');
      rethrow;
    }
  }
}
