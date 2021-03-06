import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popquiz/core/util/util.dart';
import 'package:popquiz/features/quizzes/presentation/bloc/quizzes_bloc.dart';
import 'package:popquiz/features/quizzes/presentation/widgets/page_widget.dart';

class QuestionList extends StatelessWidget {
  const QuestionList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizzesBloc, QuizzesState>(
      builder: (context, state) {
        if (state is Loading) {
          return Util.loadingWidget;
        }
        //When the state is LoadedApiQuiz there is a check to see if the quiz received from the api has the same id as the last saved quiz. If it have, the answers will be recovered.
        //Quando o estado é LoadedApiQuiz há uma verificação para saber se o quiz recebido da api tem o mesmo id do último quiz guardado. Se tiver as respostas serão recuperadas.
        if (state is LoadedApiQuiz) {
          if (Util.standByQuiz != null) {
            if (Util.standByQuiz!.id == state.remoteQuiz.id) {
              state.remoteQuiz = Util.standByQuiz!;
            }
          }
          return PageWidget(
            questions: state.remoteQuiz.questions,
          );
        }
        if (state is LoadedLocalQuiz) {
          return PageWidget(
            questions: state.localQuiz.questions,
          );
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
