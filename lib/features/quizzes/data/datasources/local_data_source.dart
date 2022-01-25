import 'package:hive/hive.dart';
import 'package:popquiz/core/error/exception.dart';
import 'package:popquiz/core/util/util.dart';
import 'package:popquiz/features/quizzes/domain/entities/quiz.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalDataSource {
  Box<Quiz> quizzesBox = Hive.box<Quiz>(Util.quizHistoryBoxName);
  List<Quiz> history = [];

  //Returns a quiz from the database according to its id, I assume different quizzes will never have the same id
  //Retorna um quetionário do banco de dados de acordo com o seu id, assumo que questionmários diferentes nunca terão o mesmo id
  Future<Quiz> getAnsweredQuizFromHistory(int quizId) {
    Quiz? answeredQuiz = quizzesBox.get(quizId);
    if (answeredQuiz != null) {
      return Future.value(answeredQuiz);
    } else {
      throw LocalDatabaseException();
    }
  }

  //Returns the history. If the box is empty, it will return an empty list.
  //Retorna o histórico. Caso a caixa esteja vazia retornará uma lista vazia.
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

  //Save the received quiz with its id as a key, a quiz with the same id will be overwritten, that is, if the user answers the same quiz only the most recent version will be saved
  //Guarda o questionário recebido tendo como chave o seu id, um questionário com o mesmo id será sobrescrito, ou seja, se o usuário responder o mesmo questionários só a versão mais recente será salva
  Future<void> storeAnsweredQuiz(Quiz quiz) {
    return quizzesBox.put(quiz.id, quiz);
  }
}
