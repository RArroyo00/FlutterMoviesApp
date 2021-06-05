// @dart=2.9
import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_credits_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_credits_provider.dart';

class MovieDetailPage extends StatelessWidget {
  final moviesCreditsProvider = new MoviesCreditsProvider();

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    final Object args = ModalRoute.of(context).settings.arguments;
    Movie movie;
    if (args != null) {
      movie = args as Movie;
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: [
            _createAppBar(movie.title, movie.getBackdroPath()),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 10,
                ),
                _titlePoster(
                    context,
                    movie.getPosterPath(),
                    movie.originalTitle,
                    movie.title,
                    movie.voteAverage,
                    movie.uuid),
                buildDivider(context, 'Overview'),
                _movieInfo(context, movie.overview),
                buildDivider(context, 'Cast'),
                _getCast(movie.id.toString(), _screenSize.height * .29),
              ]),
            )
          ],
        ));
  }

  Widget buildDivider(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Divider(),
          ),
        ],
      ),
    );
  }

  Widget _createAppBar(String title, String posterPath) {
    return SliverAppBar(
        elevation: 3,
        expandedHeight: 220,
        backgroundColor: Colors.deepOrange,
        floating: false,
        flexibleSpace: FlexibleSpaceBar(
            title: Text(title),
            background: FadeInImage(
              image: NetworkImage(posterPath),
              placeholder: AssetImage('assets/img/loading.gif'),
              fit: BoxFit.fill,
            )),
        pinned: true);
  }

  Widget _titlePoster(
      BuildContext context,
      String posterPath,
      String originalMovieTitle,
      String movieTitle,
      double voteAverage,
      String movieUUID) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Hero(
            tag: movieUUID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: NetworkImage(posterPath),
                width: 150,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movieTitle,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                originalMovieTitle,
                style: Theme.of(context).textTheme.subtitle2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.star_border_outlined),
                  Text(
                    '$voteAverage',
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _movieInfo(BuildContext context, String overview) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Text(
        overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _getCast(String movieId, double height) {
    return SizedBox(
      height: 190,
      child: FutureBuilder(
        future: moviesCreditsProvider.getMovieCast(movieId),
        builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
          if (snapshot.hasData) {
            return PageView.builder(
                controller: PageController(
                  viewportFraction: 0.29,
                  initialPage: 1,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return _createActorCart(context, snapshot.data[index]);
                });
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _createActorCart(BuildContext context, Cast data) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 3,
      child: Column(
        children: [
          FadeInImage(
            height: 160,
            image: NetworkImage(data.getCastPicturePath()),
            placeholder: AssetImage('assets/img/loading.gif'),
            fit: BoxFit.fitHeight,
          ),
          SizedBox(
            height: 3,
          ),
          Center(
            child: Text(
              data.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
