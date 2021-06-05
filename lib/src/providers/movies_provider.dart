// @dart=2.9
import 'dart:async';
import 'dart:convert';

import 'package:movies/src/constants/constants.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _path = 'api.themoviedb.org';
  int _trendingPage = 0;
  bool _isLoading = false;

  List<Movie> _trendingMovies = [];

  final _trendingStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie> movieList) get trendingsSink =>
      _trendingStreamController.sink.add;

  Stream<List<Movie>> get trendingStream => _trendingStreamController.stream;

  void disposeStreams() {
    _trendingStreamController?.close();
  }

  Future<List<Movie>> getNowPlaying() async {
    final uri = Uri.https(_path, '3/movie/now_playing', {
      'api_key': Constants.apiKey,
      'language': Constants.lang,
    });
    return await _processResponse(uri);
  }

  Future<List<Movie>> getTrending() async {
    if (_isLoading) {
      return [];
    }
    _isLoading = true;

    _trendingPage++;
    final uri = Uri.https(_path, '3/movie/popular', {
      'api_key': Constants.apiKey,
      'language': Constants.lang,
      'page': _trendingPage.toString()
    });

    final response = await _processResponse(uri);
    _trendingMovies.addAll(response);
    trendingsSink(_trendingMovies);
    _isLoading = false;
    return response;
  }

  Future<List<Movie>> _processResponse(Uri uri) async {
    final response = await http.get(uri);
    final decodedResponse = json.decode(response.body);
    final Movies movies = new Movies.fromJsonList(decodedResponse['results']);
    return movies.items;
  }
}
