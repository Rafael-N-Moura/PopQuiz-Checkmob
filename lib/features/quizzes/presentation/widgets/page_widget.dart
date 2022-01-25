import 'package:flutter/material.dart';
import 'package:popquiz/features/quizzes/domain/entities/question.dart';
import 'package:popquiz/features/quizzes/presentation/widgets/question_tile_widget.dart';

class PageWidget extends StatelessWidget {
  const PageWidget({
    Key? key,
    required this.questions,
  }) : super(key: key);

  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
      child: Material(
        elevation: 10,
        child: Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              return QuestionTile(
                question: questions[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
