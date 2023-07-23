import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/domain.dart';
import 'package:movies_app/presentation/providers/categories/discover_repository_provider.dart';

final getPosters = FutureProvider.family((ref, int genreId) {
  final repository = ref.watch(discoverRepositoryProvider);
  return repository.getMovieByGenreId(genreId: genreId, page: 1);
});
typedef DiscoverCallBack = Future<List<MovieEntity>> Function({
  required int genreId,
  required int page,
});

class DiscoverNotifier extends StateNotifier<List<MovieEntity>> {
  late int genreId;
  late int page;
  late int isLoading;
  final DiscoverCallBack fetchMovies;

  DiscoverNotifier({required this.fetchMovies}) : super([]);

  Future<List<MovieEntity>> loadPage() async {
    page = 1;
    final List<MovieEntity> movies =
        await fetchMovies(genreId: genreId, page: page);
    state = [
      ...state,
      ...movies,
    ];
    return movies;
  }
}
