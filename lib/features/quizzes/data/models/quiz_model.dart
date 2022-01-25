import 'package:popquiz/features/quizzes/data/models/question_model.dart';
import 'package:popquiz/features/quizzes/domain/entities/question.dart';
import 'package:popquiz/features/quizzes/domain/entities/quiz.dart';

class QuizModel extends Quiz {
  QuizModel({
    required int id,
    required String title,
    required List<Question> questions,
  }) : super(id: id, title: title, questions: questions);

  factory QuizModel.fromJson(Map<String, dynamic> parsedJson) {
    var aux = parsedJson['questionario'];
    var list = aux['questoes'] as List;
    List<Question> questionsList =
        list.map((q) => QuestionModel.fromJson(q)).toList();
    return QuizModel(
      id: aux['id'],
      title: aux['titulo'],
      questions: questionsList,
    );
  }
}
