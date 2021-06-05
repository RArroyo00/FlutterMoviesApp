// @dart=2.9
import 'dart:async';
import 'dart:convert';

import 'package:movies/src/constants/constants.dart';
import 'package:movies/src/models/movie_credits_model.dart';
import 'package:http/http.dart' as http;

class MoviesCreditsProvider {
  String _path = 'api.themoviedb.org';

  Future<List<Cast>> getMovieCast(String movieId) async {
    final uri = Uri.https(_path, '3/movie/$movieId/credits', {
      'api_key': Constants.apiKey,
      'language': Constants.lang,
    });
    return await _processResponse(uri);
  }

  Future<List<Cast>> _processResponse(Uri uri) async {
    final response = await http.get(uri);
    final decodedResponse = json.decode(response.body);
    final CastList movies = new CastList.fromJsonList(decodedResponse['cast']);
    return movies.items;
  }
}
