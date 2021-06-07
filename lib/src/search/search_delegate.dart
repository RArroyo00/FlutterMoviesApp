import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  final MoviesProvider moviesProvider = new MoviesProvider();

  String selected = '';

  @override
  List<Widget> buildActions(BuildContext context) {
    // Appbar Actions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: moviesProvider.moviesSearch(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final movies = snapshot.data;
          return ListView(
              children: movies!
                  .map((e) => ListTile(
                        leading: FadeInImage(
                          image: NetworkImage(e.getPosterPath()),
                          placeholder: AssetImage('assets/img/loading.gif'),
                          fit: BoxFit.contain,
                          width: 50,
                        ),
                        title: Text(e.title),
                        subtitle: Text(e.originalTitle),
                        onTap: () {
                          e.uuid = '';
                          close(context, null);
                          Navigator.pushNamed(context, 'detail', arguments: e);
                        },
                      ))
                  .toList());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
