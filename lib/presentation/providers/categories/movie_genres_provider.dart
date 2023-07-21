import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/domain.dart';

import '../providers.dart';

final getGenresProvider =
    StateNotifierProvider<MovieGenresNotifier, List<GenresEntity>>((ref) {
  final fetchGenres = ref.watch(movieDBGenreRepositoryProvider).getGenres;
  return MovieGenresNotifier(fetchGenres: fetchGenres);
});

typedef GenresCallBack = Future<List<GenresEntity>> Function();

class MovieGenresNotifier extends StateNotifier<List<GenresEntity>> {
  late bool isLoading = false;
  final GenresCallBack fetchGenres;

  MovieGenresNotifier({required this.fetchGenres}) : super([]);

  Future<void> loadPage() async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    final List<GenresEntity> allGenres = await fetchGenres();
    state = [
      ...state,
      ...allGenres,
    ];
    await Future.delayed(const Duration(milliseconds: 3));
    isLoading = false;
  }
}
