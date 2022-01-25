import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popquiz/core/util/util.dart';
import 'package:popquiz/features/quizzes/presentation/bloc/quizzes_bloc.dart';
import 'package:popquiz/features/quizzes/presentation/pages/quiz_page.dart';
import 'package:popquiz/features/quizzes/presentation/widgets/no_data_widget.dart';
import 'package:popquiz/features/quizzes/presentation/widgets/quiz_history_tile_widget.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizzesBloc, QuizzesState>(
      builder: (context, state) {
        if (state is Loading) {
          return Util.loadingWidget;
        }
        //If the list is empty a NoData Widget is shown
        //Caso a lista esteja vazia um Widget de NoData é mostrado
        if (state is LoadedHistory) {
          if (state.history.isEmpty) {
            return const NoDataWidget();
          } else {
            return ListView.builder(
              itemCount: state.history.length,
              itemBuilder: (context, index) {
                return QuizHistoryTile(
                  quiz: state.history[index],
                  function: () {
                    context.read<QuizzesBloc>().add(
                        GetQuizFromHistory(quizId: state.history[index].id));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const QuizPage();
                        },
                      ),
                    );
                  },
                );
              },
            );
          }
        }
        if (state is Error) {
          return Center(
            child: Text(
              state.message,
              style: Util.errorStyle,
            ),
          );
        }
        return Util.loadingWidget;
      },
    );
  }
}
