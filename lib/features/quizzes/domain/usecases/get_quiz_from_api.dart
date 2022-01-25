import 'package:dartz/dartz.dart';
import 'package:popquiz/core/error/failure.dart';
import 'package:popquiz/core/usecases/usecase.dart';
import 'package:popquiz/features/quizzes/domain/entities/quiz.dart';
import 'package:popquiz/features/quizzes/domain/repositories/quiz_repository.dart';

class GetQuizFromApi implements UseCase<Quiz, NoParams> {
  final QuizRepository repository;

  GetQuizFromApi(this.repository);

  @override
  Future<Either<Failure, Quiz>> call(NoParams params) async =>
      await repository.getQuizFromApi();
}
