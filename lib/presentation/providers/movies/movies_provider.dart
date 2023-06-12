import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/presentation/providers/movies/movies_repository_provider.dart';

// This provider manages the state of the now playing movies
final StateNotifierProvider<MoviesNotifier, List<MovieEntity>>
    nowPlayingMoviesProvider =
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

// This is a callback function that returns a list of movies
typedef MovieCallBack = Future<List<MovieEntity>> Function({
  int page,
  int index,
});

// This is a state notifier that manages the state of the movies
class MoviesNotifier extends StateNotifier<List<MovieEntity>> {
  late int currentPage = 0; // The current page of movies
  late int currentIndex = 0; // The current index of the movies
  final MovieCallBack fetchMoreMovies; // The function to fetch more movies

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  // This method loads the next page of movies
  Future<void> loadNextPage() async {
    currentPage++; // Increment the current page
    final List<MovieEntity> pageMovies = await fetchMoreMovies(
      page: currentPage,
    ); // Fetch the next page of movies
    state = [
      ...state,
      ...pageMovies,
    ]; // Update the state with the new page of movies
  }

  // This method sets the language of the movies to display
  Future<void> setMoviesLanguage(int moviesLanguageIndex) async {
    currentIndex =
        moviesLanguageIndex; // Set the current index to the selected index
    // Fetch the movies with the selected language
    final List<MovieEntity> movieLanguagesToDisplay = await fetchMoreMovies(
      index: currentIndex,
    );
    state = [
      ...movieLanguagesToDisplay
    ]; // Update the state with the movies with the selected language
  }
}
