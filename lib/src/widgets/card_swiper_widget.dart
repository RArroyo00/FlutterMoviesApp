// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      child: new Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.55,
          itemBuilder: (BuildContext context, int index) {
            final Movie movie = movies[index];
            movie.uuid = '${movie.id}-big';
            return Hero(
              tag: movie.uuid,
              child: _buildPosterCard(context, movie),
            );
          },
          itemCount: movies.length),
    );
  }

  Card _buildPosterCard(BuildContext context, Movie movie) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'detail', arguments: movie);
        },
        child: FadeInImage(
          image: NetworkImage(movie.getPosterPath()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
