import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/domain.dart';
import 'package:movies_app/presentation/providers/providers.dart';

//? toggle fav button
final AutoDisposeFutureProviderFamily<bool, int> isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepo = ref.watch(localStorageRepositoryProvider);

  return localStorageRepo.isFavorite(movieId);
});

//? store movies to show at favs
final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, MovieEntity>>(
  (ref) {
    final localStorageRepository = ref.watch(localStorageRepositoryProvider);
    return StorageMoviesNotifier(
        localStorageRepository: localStorageRepository);
  },
);

class StorageMoviesNotifier extends StateNotifier<Map<int, MovieEntity>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;
  StorageMoviesNotifier({
    required this.localStorageRepository,
  }) : super({});

  Future<List<MovieEntity>> loadNextPage() async {
    final movies =
        await localStorageRepository.loadMovies(offset: page * 10, limit: 15);
    page++;
    final tempMoviesMap = <int, MovieEntity>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }
    state = {
      ...state,
      ...tempMoviesMap,
    };
    return movies;
  }

  //* toggle favList (!=toggle favButton)
  Future<void> toggleFavorite(MovieEntity movie) async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavs = state[movie.id] != null;
    if (isMovieInFavs) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
