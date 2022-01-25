part of 'quizzes_bloc.dart';

abstract class QuizzesState {
  const QuizzesState();
}

class Loading extends QuizzesState {}

class LoadedHistory extends QuizzesState {
  final List<Quiz> history;

  LoadedHistory({required this.history});
}

class LoadedApiQuiz extends QuizzesState {
  Quiz remoteQuiz;

  final List<TextEditingController> controllers;

  LoadedApiQuiz({required this.remoteQuiz, required this.controllers});
}

class LoadedLocalQuiz extends QuizzesState {
  final Quiz localQuiz;

  LoadedLocalQuiz({required this.localQuiz});
}

class Error extends QuizzesState {
  final String message;

  Error({required this.message});
}
