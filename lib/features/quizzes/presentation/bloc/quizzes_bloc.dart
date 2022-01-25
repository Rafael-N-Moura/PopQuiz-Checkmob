import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:popquiz/core/usecases/usecase.dart';
import 'package:popquiz/features/quizzes/domain/entities/quiz.dart';
import 'package:popquiz/features/quizzes/domain/usecases/get_answered_quiz_from_history.dart';
import 'package:popquiz/features/quizzes/domain/usecases/get_quiz_from_api.dart';
import 'package:popquiz/features/quizzes/domain/usecases/get_quiz_history.dart';
import 'package:popquiz/features/quizzes/domain/usecases/store_answered_quiz.dart';

part 'quizzes_event.dart';
part 'quizzes_state.dart';

const String SERVER_FAILURE =
    'Problemas no servidor, tente novamente mais tarde!';
const String LOCAL_DATABASE_FAILURE =
    'Ocorreu um erro e as informações não puderam ser carreagadas!';

class QuizzesBloc extends Bloc<QuizzesEvent, QuizzesState> {
  final GetQuizHistory getQuizHistory;
  final GetAnsweredQuizFromHistory getAnsweredQuizFromHistory;
  final GetQuizFromApi getQuizFromApi;
  final StoreAnsweredQuiz storeAnsweredQuiz;

  QuizzesBloc({
    required this.getQuizHistory,
    required this.getAnsweredQuizFromHistory,
    required this.getQuizFromApi,
    required this.storeAnsweredQuiz,
  }) : super(Loading()) {
    on<GetHistory>(getHistory);
    on<GetQuizFromHistory>(getQuizFromHistory);
    on<GetApiQuiz>(getApiQuiz);
    on<StoreQuiz>(storeQuiz);
  }

  void getHistory(GetHistory event, Emitter<QuizzesState> emit) async {
    emit(Loading());
    final history = await getQuizHistory(NoParams());
    history.fold(
      (failure) => emit(
        Error(message: LOCAL_DATABASE_FAILURE),
      ),
      (sucessHistory) => emit(
        LoadedHistory(history: sucessHistory),
      ),
    );
  }

  void getQuizFromHistory(
      GetQuizFromHistory event, Emitter<QuizzesState> emit) async {
    emit(Loading());
    final quiz =
        await getAnsweredQuizFromHistory(IdParams(quizId: event.quizId));
    quiz.fold(
      (failure) => emit(
        Error(message: LOCAL_DATABASE_FAILURE),
      ),
      (sucessQuiz) => emit(
        LoadedLocalQuiz(localQuiz: sucessQuiz),
      ),
    );
  }

  void getApiQuiz(GetApiQuiz event, Emitter<QuizzesState> emit) async {
    List<TextEditingController> controllers = [];
    emit(Loading());
    final quiz = await getQuizFromApi(
      NoParams(),
    );
    quiz.fold(
      (failure) => emit(
        Error(message: SERVER_FAILURE),
      ),
      (sucessQuiz) {
        for (int i = 0; i < sucessQuiz.questions.length; i++) {
          controllers.add(TextEditingController());
        }
        emit(
          LoadedApiQuiz(remoteQuiz: sucessQuiz, controllers: controllers),
        );
      },
    );
  }

  void storeQuiz(StoreQuiz event, Emitter<QuizzesState> emit) async {
    emit(Loading());
    final result = await storeAnsweredQuiz(QuizParams(quiz: event.quiz));
    result.fold(
      (failure) => Error(message: LOCAL_DATABASE_FAILURE),
      (sucess) => emit(LoadedLocalQuiz(localQuiz: event.quiz)),
    );
  }
}
