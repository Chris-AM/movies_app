import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/domain/domain.dart';
import 'package:movies_app/presentation/helpers/helpers.dart';

class MoviePosterLink extends StatelessWidget {
  final MovieEntity movie;
  const MoviePosterLink({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final String movieId = movie.id.toString();
    return FadeInUp(
      child: GestureDetector(
        onTap: () => PushToMovieHelper.pushToMovie(context, movieId: movieId),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(movie.posterPath),
        ),
      ),
    );
  }
}
