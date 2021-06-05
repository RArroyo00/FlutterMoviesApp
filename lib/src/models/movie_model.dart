// @dart=2.9
class MoviesResponse {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  MoviesResponse({this.page, this.results, this.totalPages, this.totalResults});

  MoviesResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(new Movie.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}

class Movies {
  List<Movie> items = [];
  Movies();
  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList != null) {
      for (var item in jsonList) {
        final Movie movie = new Movie.fromJson(item);
        items.add(movie);
      }
    }
  }
}

class Movie {
  String _uuid;

  String get uuid => _uuid;

  set uuid(String uuid) {
    _uuid = uuid;
  }

  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  Movie.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['genre_ids'] = this.genreIds;
    data['id'] = this.id;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['title'] = this.title;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    return data;
  }

  String getPosterPath() {
    if (posterPath == null) {
      return 'https://th.bing.com/th/id/R13348c2f20e67df7c41f02508c3db817?rik=UimwEaESh%2fsMKg&pid=ImgRaw';
    } else {
      return "https://image.tmdb.org/t/p/w500/$posterPath";
    }
  }

  String getBackdroPath() {
    if (posterPath == null) {
      return 'https://th.bing.com/th/id/R13348c2f20e67df7c41f02508c3db817?rik=UimwEaESh%2fsMKg&pid=ImgRaw';
    } else {
      return "https://image.tmdb.org/t/p/w500/$backdropPath";
    }
  }
}
