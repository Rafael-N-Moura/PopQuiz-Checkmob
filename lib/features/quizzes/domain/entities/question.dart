import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'question.g.dart';

@HiveType(typeId: 1)
class Question {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String answer;

  Question({
    required this.id,
    required this.title,
    required this.description,
    required this.answer,
  });
}
