import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/domain.dart';
import 'package:movies_app/presentation/providers/movies/movies_repository_provider.dart';

// This provider manages the state of the now playing movies
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieEntity>>(
  (ref) {
    // Get the function to fetch more movies from the repository
    final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
    // Return a new instance of the MoviesNotifier with the fetchMoreMovies function
    return MoviesNotifier(
      fetchMoreMovies: fetchMoreMovies,
    );
  },
);

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieEntity>>(
  (ref) {
    // Get the function to fetch more movies from the repository
    final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
    // Return a new instance of the MoviesNotifier with the fetchMoreMovies function
    return MoviesNotifier(
      fetchMoreMovies: fetchMoreMovies,
    );
  },
);

final upComingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieEntity>>(
  (ref) {
    // Get the function to fetch more movies from the repository
    final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
    // Return a new instance of the MoviesNotifier with the fetchMoreMovies function
    return MoviesNotifier(
      fetchMoreMovies: fetchMoreMovies,
    );
  },
);

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieEntity>>(
  (ref) {
    // Get the function to fetch more movies from the repository
    final fetchMoreMovies = ref.watch(movieRepositoryProvider).topRated;
    // Return a new instance of the MoviesNotifier with the fetchMoreMovies function
    return MoviesNotifier(
      fetchMoreMovies: fetchMoreMovies,
    );
  },
);

// This is a callback function that returns a list of movies
typedef MovieCallBack = Future<List<MovieEntity>> Function(int page);

// This is a state notifier that manages the state of the movies
class MoviesNotifier extends StateNotifier<List<MovieEntity>> {
  late int currentPage = 0;
  late int currentIndex = 0;
  late bool isLoading = false;
  final MovieCallBack fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  // This method loads the next page of movies
  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    // Fetch the next page of movies
    final List<MovieEntity> pageMovies = await fetchMoreMovies(currentPage);
    // Update the state with the new page of movies
    state = [
      ...state,
      ...pageMovies,
    ];
    await Future.delayed(
      const Duration(milliseconds: 3),
    );
    isLoading = false;
  }

  // This method sets the language of the movies to display
  Future<void> setMoviesLanguage(int moviesLanguageIndex) async {
    currentIndex =
        moviesLanguageIndex; // Set the current index to the selected index
    // Fetch the movies with the selected language
    final List<MovieEntity> movieLanguagesToDisplay =
        await fetchMoreMovies(moviesLanguageIndex);
    state = [
      ...movieLanguagesToDisplay
    ]; // Update the state with the movies with the selected language
  }
}
