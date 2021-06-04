// @dart=2.9
import 'dart:convert';

import 'package:movies/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = 'f12cbc5d2e9fc9c0e82af54821520a27';
  String _path = 'api.themoviedb.org';
  String _lang = 'en-US';

  Future<List<Movie>> getNowPlaying() async {
    final uri = Uri.https(_path, "3/movie/now_playing", {
      'api_key': _apiKey,
      'language': _lang,
    });
    return await _processResponse(uri);
  }

  Future<List<Movie>> getTrending() async {
    final uri = Uri.https(_path, "3/movie/popular", {
      'api_key': _apiKey,
      'language': _lang,
    });
    return await _processResponse(uri);
  }

  Future<List<Movie>> _processResponse(Uri uri) async {
    final response = await http.get(uri);
    final decodedResponse = json.decode(response.body);
    final Movies movies = new Movies.fromJsonList(decodedResponse['results']);
    return movies.items;
  }
}
