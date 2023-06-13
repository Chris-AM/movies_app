import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<MovieEntity> movies;
  const MoviesSlideshow({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: .9,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            color: colors.primary,
            activeColor: colors.secondary,
          ),
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _Carrousel(movie: movie);
        },
      ),
    );
  }
}

class _Carrousel extends StatelessWidget {
  final MovieEntity movie;

  const _Carrousel({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final BoxDecoration decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10),
        ),
      ],
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                // TODO: change pattern when loading
                return const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black45),
                );
              }
              return FadeIn(child: child);
            },
          ),
        ),
      ),
    );
  }
}
