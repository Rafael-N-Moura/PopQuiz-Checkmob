import 'package:hive/hive.dart';
import 'package:popquiz/core/error/exception.dart';
import 'package:popquiz/core/util/util.dart';
import 'package:popquiz/features/quizzes/domain/entities/quiz.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalDataSource {
  Box<Quiz> quizzesBox = Hive.box<Quiz>(Util.quizHistoryBoxName);
  List<Quiz> history = [];

  //Retorna um quetionário do banco de dados de acordo com o seu id, assumo que questionmários diferentes nunca terão o mesmo id
  Future<Quiz> getAnsweredQuizFromHistory(int quizId) {
    Quiz? answeredQuiz = quizzesBox.get(quizId);
    if (answeredQuiz != null) {
      return Future.value(answeredQuiz);
    } else {
      throw LocalDatabaseException();
    }
  }

  //Retorna o histórico
  Future<List<Quiz>> getQuizHistory() {
    history.clear();
    if (quizzesBox.isNotEmpty) {
      for (var key in quizzesBox.keys) {
        var quiz = quizzesBox.get(key);
        if (quiz != null) {
          history.add(quiz);
        } else {
          throw LocalDatabaseException();
        }
      }
    }
    return Future.value(history);
  }

  //Guarda o questionário recebido tendo como chave o seu id, um questionário com o mesmo id será sobrescrito, ou seja, se o usuário responder o mesmo questionários só a versão mais recente será salva
  Future<void> storeAnsweredQuiz(Quiz quiz) {
    return quizzesBox.put(quiz.id, quiz);
  }
}
