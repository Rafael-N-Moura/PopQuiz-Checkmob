import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:popquiz/core/error/exception.dart';
import 'package:popquiz/features/quizzes/data/models/quiz_model.dart';

class RemoteDataSource {
  Client client = Client();
  String url =
      'https://my-json-server.typicode.com/Rafael-N-Moura/fixtures2/db';

  //Retorna um QuizModel vindo do formato JSON
  Future<QuizModel> getQuizFromApi() async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return QuizModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
