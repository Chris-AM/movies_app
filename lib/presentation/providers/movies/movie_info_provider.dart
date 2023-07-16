import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/domain.dart';
import 'package:movies_app/presentation/providers/providers.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, MovieEntity>>(
  (ref) {
    final fetchMovie = ref.watch(movieRepositoryProvider).getMovieById;
    return MovieMapNotifier(getMovieCallBack: fetchMovie);
  },
);

typedef GetMovieCallBack = Future<MovieEntity> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, MovieEntity>> {
  late int currentIndex = 0;
  final GetMovieCallBack getMovieCallBack;

  MovieMapNotifier({
    required this.getMovieCallBack,
  }) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    final MovieEntity movie = await getMovieCallBack(movieId);
    state = {...state, movieId: movie};
  }
}
