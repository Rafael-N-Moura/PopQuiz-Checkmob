import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popquiz/core/util/util.dart';
import 'package:popquiz/features/quizzes/domain/entities/question.dart';
import 'package:popquiz/features/quizzes/presentation/bloc/quizzes_bloc.dart';

class QuestionTile extends StatefulWidget {
  const QuestionTile({Key? key, required this.question}) : super(key: key);

  final Question question;

  @override
  State<QuestionTile> createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizzesBloc, QuizzesState>(
      builder: (context, state) {
        if (state is LoadedApiQuiz) {
          //Caso haja respostas salvas da última vez que o usúario abriu esse quiz na sessão atual, essas respostas serão postas como valor inical nos TextFields. Caso não haja continuarão em branco
          //"widget.question.id - 1" pois os ids das questões começam em 1 mas o index na lista começa em 0
          state.controllers[widget.question.id - 1].text =
              widget.question.answer;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.question.title,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.question.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
    
                    controller: state.controllers[widget.question.id - 1],
                    onChanged: (value) {
                      state.remoteQuiz.questions[widget.question.id - 1]
                          .answer = value;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        }
        if (state is LoadedLocalQuiz) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.question.title,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.question.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Sua resposta: ',
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    children: [
                      TextSpan(
                        text: widget.question.answer,
                        style: const TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        }
        return const Center(
          child: Text(
            'Erro Inesperado',
            style: Util.errorStyle,
          ),
        );
      },
    );
  }
}
