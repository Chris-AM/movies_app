//* Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//* Own Imports
import '/domain/domain.dart';
import '/presentation/widgets/movies/movies_horizontal_listview.dart';
import '../../providers/providers.dart';

class SimilarMovies extends ConsumerWidget {
  final int movieId;

  const SimilarMovies({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarMoviesFuture = ref.watch(similarMoviesProvider(movieId));
    return similarMoviesFuture.when(
      data: (movies) {
        return _Recommendations(movies: movies);
      },
      error: (_, __) =>
          const Center(child: Text("Couldn't fetch similar movies")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _Recommendations extends StatelessWidget {
  final List<MovieEntity> movies;

  const _Recommendations({required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 50),
      child: MoviesHorizontalListView(
        title: 'Recommendations',
        movies: movies,
      ),
    );
  }
}
