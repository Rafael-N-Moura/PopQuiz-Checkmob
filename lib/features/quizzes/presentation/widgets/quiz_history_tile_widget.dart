import 'package:flutter/material.dart';
import 'package:popquiz/features/quizzes/domain/entities/quiz.dart';

class QuizHistoryTile extends StatelessWidget {
  QuizHistoryTile({
    Key? key,
    required this.quiz,
    required this.function,
  }) : super(key: key);

  Quiz quiz;
  Function() function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: 150,
            child: Image.asset(
              'assets/images/essay.png',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              quiz.title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
