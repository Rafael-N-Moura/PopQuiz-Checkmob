import 'package:dartz/dartz.dart';
import 'package:popquiz/core/error/exception.dart';
import 'package:popquiz/core/error/failure.dart';
import 'package:popquiz/features/quizzes/data/datasources/local_data_source.dart';
import 'package:popquiz/features/quizzes/data/datasources/remote_data_source.dart';
import 'package:popquiz/features/quizzes/domain/entities/quiz.dart';
import 'package:popquiz/features/quizzes/domain/repositories/quiz_repository.dart';

class QuizRepositoryImplementation implements QuizRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  QuizRepositoryImplementation(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, Quiz>> getAnsweredQuizFromHistory(int quizId) async {
    try {
      final localQuiz =
          await localDataSource.getAnsweredQuizFromHistory(quizId);
      return Right(localQuiz);
    } on LocalDatabaseException {
      return Left(LocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Quiz>> getQuizFromApi() async {
    try {
      final remoteQuiz = await remoteDataSource.getQuizFromApi();
      return Right(remoteQuiz);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Quiz>>> getQuizHistory() async {
    try {
      final localQuizHistory = await localDataSource.getQuizHistory();
      return Right(localQuizHistory);
    } on LocalDatabaseException {
      return Left(LocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> storeAnsweredQuiz(Quiz quiz) async {
    try {
      return Right(await localDataSource.storeAnsweredQuiz(quiz));
    } on LocalDatabaseException {
      return Left(LocalDatabaseFailure());
    }
  }
}
