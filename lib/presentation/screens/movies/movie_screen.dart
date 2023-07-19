import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/domain.dart';
import 'package:movies_app/presentation/providers/providers.dart';
import 'package:movies_app/presentation/widgets/movies/similar_movies.dart';
import 'package:movies_app/presentation/widgets/videos/videos_from_movie.dart';

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
    // final int movieLanguageIndex = ref.read(moviesLanguageIndexProvider);
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(castByMovieProvider.notifier).loadCast(widget.movieId);
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

class _MovieDetailAppBar extends ConsumerWidget {
  final MovieEntity movie;
  const _MovieDetailAppBar({
    required this.movie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProvider = ref.watch(
      isFavoriteProvider(movie.id),
    );
    final size = MediaQuery.of(context).size;
    final ColorScheme colors = Theme.of(context).colorScheme;
    return SliverAppBar(
      actions: [
        IconButton(
          onPressed: () async {
            // ref.read(localStorageRepositoryProvider).toggleFavorite(movie);
            await ref
                .read(favoriteMoviesProvider.notifier)
                .toggleFavorite(movie);
          },
          icon: favoriteProvider.when(
              loading: () => const CircularProgressIndicator(),
              data: (isFav) {
                ref.invalidate(isFavoriteProvider(movie.id));
                if (isFav) {
                  return Icon(
                    Icons.favorite_rounded,
                    color: colors.primary,
                  );
                }
                return const Icon(Icons.favorite_border);
              },
              error: (_, __) => throw UnimplementedError()),
        ),
      ],
      expandedHeight: size.height * .7,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
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
        _TitleAndOverview(movie: movie, size: size, textStyle: textStyle),
        _Genres(movie: movie),
        _CastByMovie(movieId: movie.id.toString()),
        VideosFromMovie(movieId: movie.id),
        SimilarMovies(movieId: movie.id),
      ],
    );
  }
}

class _Genres extends StatelessWidget {
  const _Genres({
    super.key,
    required this.movie,
  });

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class _TitleAndOverview extends StatelessWidget {
  const _TitleAndOverview({
    required this.movie,
    required this.size,
    required this.textStyle,
  });

  final MovieEntity movie;
  final Size size;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class _CastByMovie extends ConsumerWidget {
  final String movieId;
  const _CastByMovie({
    required this.movieId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final castByMovie = ref.watch(castByMovieProvider);
    if (castByMovie[movieId] == null) {
      return const CircularProgressIndicator();
    }
    final cast = castByMovie[movieId]!;
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cast.length,
        itemBuilder: (context, index) {
          final actor = cast[index];
          return Container(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 5,
              left: 8,
              right: 5,
            ),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(actor.name),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const SizedBox();
              }
              return FadeIn(child: child);
            },
          ),
        ),
        const _CustomGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.7, 1.0],
          colors: [
            Colors.transparent,
            Colors.black54,
          ],
        ),
        const _CustomGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.0, 0.2],
          colors: [
            Colors.black87,
            Colors.transparent,
          ],
        ),
        const _CustomGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerLeft,
          stops: [
            0.0,
            0.3,
          ],
          colors: [
            Colors.black87,
            Colors.transparent,
          ],
        ),
      ],
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;
  const _CustomGradient({
    required this.begin,
    required this.end,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
