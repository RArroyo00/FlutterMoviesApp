// @dart=2.9
import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class HorizontalMovieSlider extends StatelessWidget {
  final List<Movie> moviesList;
  HorizontalMovieSlider({@required this.moviesList});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * .25,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: .3,
        ),
        children: _cardList(context),
      ),
    );
  }

  List<Widget> _cardList(BuildContext context) {
    return moviesList.map((e) {
      return Container(
        margin: EdgeInsets.only(right: 8),
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 3,
              child: Column(
                children: [
                  FadeInImage(
                    height: 155,
                    image: NetworkImage(e.getPosterPath()),
                    placeholder: AssetImage('assets/img/loading.gif'),
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text(
                      e.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
