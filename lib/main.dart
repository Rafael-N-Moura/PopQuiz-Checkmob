import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popquiz/features/quizzes/domain/entities/quiz.dart';
import 'package:popquiz/features/quizzes/presentation/pages/quiz_history_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'core/util/util.dart';
import 'features/quizzes/data/datasources/local_data_source.dart';
import 'features/quizzes/data/datasources/remote_data_source.dart';
import 'features/quizzes/data/repositories/quiz_repository_implementation.dart';
import 'features/quizzes/domain/entities/question.dart';
import 'features/quizzes/domain/usecases/get_answered_quiz_from_history.dart';
import 'features/quizzes/domain/usecases/get_quiz_from_api.dart';
import 'features/quizzes/domain/usecases/get_quiz_history.dart';
import 'features/quizzes/domain/usecases/store_answered_quiz.dart';
import 'features/quizzes/presentation/bloc/quizzes_bloc.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Quiz>(QuizAdapter());
  Hive.registerAdapter<Question>(QuestionAdapter());
  await Hive.openBox<Quiz>(Util.quizHistoryBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizzesBloc(
          getQuizHistory: GetQuizHistory(QuizRepositoryImplementation(
              RemoteDataSource(), LocalDataSource())),
          getAnsweredQuizFromHistory: GetAnsweredQuizFromHistory(
              QuizRepositoryImplementation(
                  RemoteDataSource(), LocalDataSource())),
          getQuizFromApi: GetQuizFromApi(QuizRepositoryImplementation(
              RemoteDataSource(), LocalDataSource())),
          storeAnsweredQuiz: StoreAnsweredQuiz(QuizRepositoryImplementation(
              RemoteDataSource(), LocalDataSource()))),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PopQuiz',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Nunito',
        ),
        home: const QuizHistoryPage(),
      ),
    );
  }
}
