import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate {
  final movies = ['Batman', 'Persépolis', 'Calabacín', 'Spiderman', 'Hulk'];
  final recentMovies = ['The shining', 'Control'];
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
    //Can display a widget with results!
    /*
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.redAccent,
        child: Text(selected),
      ),
    );*/
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredList = (query.isEmpty)
        ? recentMovies
        : movies
            .where(
              (element) =>
                  element.toLowerCase().startsWith(query.toLowerCase()),
            )
            .toList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(filteredList[index]),
          onTap: () {
            selected = filteredList[index];
            //  showResults(context); <= display results
          },
        );
      },
    );
  }
}
