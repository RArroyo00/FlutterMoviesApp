// @dart=2.9
import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/search/search_delegate.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/horizontal_movie_slider.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getTrending();
    return Scaffold(
      appBar: AppBar(
        title: Text('New movies'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
                // query: 'Preloaded query',
              );
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _createHeaderSwiper(),
              _createFooterSlider(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createHeaderSwiper() {
    return FutureBuilder(
      future: moviesProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CardSwiper(movies: snapshot.data),
          );
        } else {
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _createFooterSlider(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  'Trending',
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
          ),
          StreamBuilder(
              stream: moviesProvider.trendingStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return HorizontalMovieSlider(
                    moviesList: snapshot.data,
                    endScrollAction: moviesProvider.getTrending,
                  );
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height * .25,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
          /*
          FutureBuilder(
              future: moviesProvider.getTrending(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return HorizontalMovieSlider(moviesList: snapshot.data);
                } else {
                  return Container(
                    height: 400,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),*/
        ],
      ),
    );
  }
}
