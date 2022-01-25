part of 'quizzes_bloc.dart';

abstract class QuizzesEvent {
  const QuizzesEvent();
}

class GetQuizFromHistory extends QuizzesEvent {
  final int quizId;

  GetQuizFromHistory({required this.quizId});
}

class GetApiQuiz extends QuizzesEvent {}

class GetHistory extends QuizzesEvent {}

class StoreQuiz extends QuizzesEvent {
  final Quiz quiz;

  StoreQuiz({required this.quiz});
}
