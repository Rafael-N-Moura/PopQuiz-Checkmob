import 'package:flutter/material.dart';
import 'package:popquiz/features/quizzes/domain/entities/quiz.dart';

class Util {
  static const quizHistoryBoxName = 'quiz-history';
  static const backgroundImage = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/backgroundImage.jfif'),
      fit: BoxFit.cover,
    ),
  );
  static const heeaderTextStyle = TextStyle(color: Colors.white, fontSize: 40);
  static const errorStyle = TextStyle(fontSize: 30, color: Colors.white);
  static const loadingWidget = Center(child: CircularProgressIndicator());
  static Quiz? standByQuiz;
}
