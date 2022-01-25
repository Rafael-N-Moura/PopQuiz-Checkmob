import 'package:dartz/dartz.dart';
import 'package:popquiz/core/error/failure.dart';
import 'package:popquiz/core/usecases/usecase.dart';
import 'package:popquiz/features/quizzes/domain/entities/quiz.dart';
import 'package:popquiz/features/quizzes/domain/repositories/quiz_repository.dart';

class GetQuizHistory implements UseCase<List<Quiz>, NoParams> {
  final QuizRepository repository;

  GetQuizHistory(this.repository);

  @override
  Future<Either<Failure, List<Quiz>>> call(NoParams params) async =>
      await repository.getQuizHistory();
}
