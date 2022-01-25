import 'package:dartz/dartz.dart';
import 'package:popquiz/core/error/failure.dart';
import 'package:popquiz/features/quizzes/domain/entities/quiz.dart';

abstract class QuizRepository {
  Future<Either<Failure, Quiz>> getAnsweredQuizFromHistory(int quizId);
  Future<Either<Failure, Quiz>> getQuizFromApi();
  Future<Either<Failure, List<Quiz>>> getQuizHistory();
  Future<Either<Failure, void>> storeAnsweredQuiz(Quiz quiz);
}
