import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popquiz/core/util/util.dart';
import 'package:popquiz/features/quizzes/presentation/bloc/quizzes_bloc.dart';
import 'package:popquiz/features/quizzes/presentation/widgets/header_widget.dart';
import 'package:popquiz/features/quizzes/presentation/widgets/question_list_widget.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizzesBloc, QuizzesState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () {
            if (state is LoadedApiQuiz) {
              Util.standByQuiz = state.remoteQuiz;
            }
            Navigator.pop(context, false);
            context.read<QuizzesBloc>().add(GetHistory());
            return Future.value(false);
          },
          child: Scaffold(
            body: Container(
              decoration: Util.backgroundImage,
              child: SafeArea(
                child: Column(
                  children: [
                    BlocBuilder<QuizzesBloc, QuizzesState>(
                      builder: (context, state) {
                        if (state is LoadedApiQuiz) {
                          return Header(
                            label: state.remoteQuiz.title,
                            icon: const Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            function: () {
                              for (var controller in state.controllers) {
                                //Validação
                                if (controller.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Por favor preencha todos os campos',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                  return;
                                }
                              }

                              context
                                  .read<QuizzesBloc>()
                                  .add(StoreQuiz(quiz: state.remoteQuiz));
                            },
                          );
                        }
                        if (state is LoadedLocalQuiz) {
                          return Header(
                            label: state.localQuiz.title,
                            icon: const Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            function: () {
                              context.read<QuizzesBloc>().add(GetHistory());
                              Navigator.pop(context);
                            },
                          );
                        }
                        return Header(
                          label: 'Carregando',
                          icon: const Icon(Icons.alarm, color: Colors.white),
                          function: () {},
                        );
                      },
                    ),
                    const Expanded(
                      child: QuestionList(),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
