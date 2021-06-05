// @dart=2.9
import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class HorizontalMovieSlider extends StatelessWidget {
  final List<Movie> moviesList;
  final Function endScrollAction;

  HorizontalMovieSlider(
      {@required this.moviesList, @required this.endScrollAction});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: .3,
    );

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        endScrollAction();
      }
    });

    return Container(
      height: _screenSize.height * .25,
      child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
          itemCount: moviesList.length, //IMPORTANT
          itemBuilder: (context, i) =>
              _createTrendingCard(context, moviesList[i])),
    );
  }

  Widget _createTrendingCard(BuildContext context, Movie movie) {
    movie.uuid = '${movie.id}-trending';
    final movieCard = Hero(
      tag: movie.uuid,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 3,
        child: Column(
          children: [
            FadeInImage(
              height: 155,
              image: NetworkImage(movie.getPosterPath()),
              placeholder: AssetImage('assets/img/loading.gif'),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Text(
                movie.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            )
          ],
        ),
      ),
    );

    final movieCardContainer = Container(
      margin: EdgeInsets.only(right: 8),
      child: Column(
        children: [
          GestureDetector(
            child: movieCard,
            onTap: () {
              Navigator.pushNamed(context, 'detail', arguments: movie);
            },
          )
        ],
      ),
    );

    return movieCardContainer;
  }

/*
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
  */
}
