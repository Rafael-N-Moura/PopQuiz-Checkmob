import 'package:flutter/material.dart';
import 'package:popquiz/core/util/util.dart';
import 'package:popquiz/features/quizzes/presentation/bloc/quizzes_bloc.dart';
import 'package:popquiz/features/quizzes/presentation/pages/quiz_page.dart';
import 'package:popquiz/features/quizzes/presentation/widgets/header_widget.dart';
import 'package:popquiz/features/quizzes/presentation/widgets/history_list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizHistoryPage extends StatefulWidget {
  const QuizHistoryPage({Key? key}) : super(key: key);

  @override
  State<QuizHistoryPage> createState() => _QuizHistoryPageState();
}

class _QuizHistoryPageState extends State<QuizHistoryPage> {
  @override
  void initState() {
    context.read<QuizzesBloc>().add(GetHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Util.backgroundImage,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Header(
                  label: 'Histórico',
                  icon: const Icon(Icons.add, color: Colors.white),
                  function: () {
                    context.read<QuizzesBloc>().add(GetApiQuiz());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const QuizPage();
                        },
                      ),
                    );
                  },
                ),
              ),
              const Expanded(
                flex: 7,
                child: HistoryList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
