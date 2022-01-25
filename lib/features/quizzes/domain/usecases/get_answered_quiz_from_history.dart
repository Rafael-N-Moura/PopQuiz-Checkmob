import 'package:dartz/dartz.dart';
import 'package:popquiz/core/error/failure.dart';
import 'package:popquiz/core/usecases/usecase.dart';
import 'package:popquiz/features/quizzes/domain/entities/quiz.dart';
import 'package:popquiz/features/quizzes/domain/repositories/quiz_repository.dart';

//Os parâmetros são definidos dessa forma pois o contrato para os casos de uso foi definido no core, um espaço comum para todas as features
class GetAnsweredQuizFromHistory implements UseCase<Quiz, IdParams> {
  final QuizRepository repository;

  GetAnsweredQuizFromHistory(this.repository);

  @override
  Future<Either<Failure, Quiz>> call(IdParams params) async =>
      await repository.getAnsweredQuizFromHistory(params.quizId);
}

class IdParams {
  final int quizId;

  IdParams({required this.quizId});
}
