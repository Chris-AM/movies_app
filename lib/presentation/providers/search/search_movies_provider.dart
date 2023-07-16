import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/domain.dart';
import 'package:movies_app/presentation/providers/providers.dart';

final searchTermProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<MovieEntity>>(
  (ref) {
    final movieRepository = ref.read(movieRepositoryProvider);

    return SearchedMoviesNotifier(
      searchedMovies: movieRepository.searchMovies,
      ref: ref,
    );
  },
);

typedef SearchMoviesCallback = Future<List<MovieEntity>> Function(
    String searchTerm);

class SearchedMoviesNotifier extends StateNotifier<List<MovieEntity>> {
  final SearchMoviesCallback searchedMovies;
  final Ref ref;

  SearchedMoviesNotifier({
    required this.searchedMovies,
    required this.ref,
  }) : super([]);

  Future<List<MovieEntity>> searchMoviesByQuery(String searchTerm) async {
    final List<MovieEntity> movies = await searchedMovies(searchTerm);
    ref.read(searchTermProvider.notifier).update((state) => searchTerm);

    state = movies;
    return movies;
  }
}
