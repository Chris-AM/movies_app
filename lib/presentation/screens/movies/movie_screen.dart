import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/entities/entities.dart';
import 'package:movies_app/presentation/providers/movies/movie_info_provider.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie_screen';
  final String movieId;
  const MovieScreen({
    super.key,
    required this.movieId,
  });

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final MovieEntity? movie = ref.watch(movieInfoProvider)[widget.movieId];
    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _MovieDetailAppBar(
            movie: movie,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(
                movie: movie,
              ),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}

class _MovieDetailAppBar extends StatelessWidget {
  final MovieEntity movie;
  const _MovieDetailAppBar({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      expandedHeight: size.height * .7,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        title: Text(
          movie.title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        background: _AppBarImage(movie: movie),
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final MovieEntity movie;
  const _MovieDetails({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * .3,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: (size.width - 40) * .7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      movie.title,
                      style: textStyle.titleMedium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      movie.overview,
                      style: textStyle.bodySmall,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map(
                (gender) => Container(
                  margin: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Chip(
                    label: Text(gender),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}

class _AppBarImage extends StatelessWidget {
  const _AppBarImage({
    required this.movie,
  });

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.network(
            movie.posterPath,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox.expand(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black87,
                ],
              ),
            ),
          ),
        ),
        const SizedBox.expand(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                stops: [
                  0.0,
                  0.3,
                ],
                colors: [
                  Colors.black87,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
