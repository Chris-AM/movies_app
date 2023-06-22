import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/entities/entities.dart';
import 'package:movies_app/presentation/providers/providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

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

typedef SearchMoviesCallback = Future<List<MovieEntity>> Function({
  String searchTerm,
  int movieLanguageIndex,
});

class SearchedMoviesNotifier extends StateNotifier<List<MovieEntity>> {
  final SearchMoviesCallback searchedMovies;
  final Ref ref;

  SearchedMoviesNotifier({
    required this.searchedMovies,
    required this.ref,
  }) : super([]);

  Future<List<MovieEntity>> searchMoviesByQuery(
      {String searchTerm = '', int movieLanguageIndex = 0}) async {
    final List<MovieEntity> movies =
        await searchedMovies(searchTerm: searchTerm);
    ref.read(searchQueryProvider.notifier).update((state) => searchTerm);

    state = movies;
    return movies;
  }
}
