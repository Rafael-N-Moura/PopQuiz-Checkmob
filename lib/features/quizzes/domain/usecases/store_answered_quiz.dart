import 'package:dartz/dartz.dart';
import 'package:popquiz/core/error/failure.dart';
import 'package:popquiz/core/usecases/usecase.dart';
import 'package:popquiz/features/quizzes/domain/entities/quiz.dart';
import 'package:popquiz/features/quizzes/domain/repositories/quiz_repository.dart';

class StoreAnsweredQuiz implements UseCase<void, QuizParams> {
  final QuizRepository repository;

  StoreAnsweredQuiz(this.repository);

  @override
  Future<Either<Failure, void>> call(QuizParams params) async =>
      await repository.storeAnsweredQuiz(params.quiz);
}

class QuizParams {
  final Quiz quiz;

  QuizParams({required this.quiz});
}
