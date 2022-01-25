import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:popquiz/features/quizzes/domain/entities/question.dart';

part 'quiz.g.dart';

@HiveType(typeId: 0)
class Quiz {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.questions,
  });
}
