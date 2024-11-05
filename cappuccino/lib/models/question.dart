import 'dart:convert';
import 'package:flutter/services.dart';

class Question {
  String title;
  String min;
  String max;

  Question({
    required this.title,
    required this.min,
    required this.max,
  });

  static Question fromMap(Map map) {
    Question q = Question(
      title: map['titulo'],
      min: map['min'],
      max: map['max'],
    );
    return q;
  }

  static Future<List<Question>> loadQuestions() async {
    final jsonString =
        await rootBundle.loadString('assets/json/questions.json');
    final List<dynamic> jsonDecoded = jsonDecode(jsonString) as List<dynamic>;
    return jsonDecoded
        .map((dynamic item) => Question.fromMap(item as Map<String, dynamic>))
        .toList();
  }
}
