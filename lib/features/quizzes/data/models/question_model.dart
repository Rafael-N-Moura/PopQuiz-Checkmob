import 'package:popquiz/features/quizzes/domain/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel({
    required int id,
    required String title,
    required String description,
    required String answer,
  }) : super(id: id, title: title, description: description, answer: answer);

  factory QuestionModel.fromJson(Map<String, dynamic> parsedJson) {
    return QuestionModel(
      id: parsedJson['id'],
      title: parsedJson['titulo'],
      description: parsedJson['descricao'],
      answer: '',
    );
  }
}
