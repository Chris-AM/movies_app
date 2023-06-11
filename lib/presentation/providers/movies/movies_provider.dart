import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/presentation/providers/movies/movies_repository_provider.dart';

final StateNotifierProvider<MoviesNotifier, List<MovieEntity>>
    nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieEntity>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

typedef MovieCallBack = Future<List<MovieEntity>> Function({
  int page,
  int index,
});

class MoviesNotifier extends StateNotifier<List<MovieEntity>> {
  int currentPage = 0;
  int currentIndex = 0;
  MovieCallBack fetchMoreMovies;
  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    currentPage++;
    final List<MovieEntity> pageMovies = await fetchMoreMovies(
      page: currentPage,
    );
    state = [...state, ...pageMovies];
  }

  Future<void> setMoviesLanguage(int moviesLanguageIndex) async {
    moviesLanguageIndex = currentIndex;
    final List<MovieEntity> languagesToShow =
        await fetchMoreMovies(index: currentIndex);
    state = [...state, ...languagesToShow];
  }
}
