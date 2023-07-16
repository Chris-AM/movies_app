import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/domain.dart';
import 'package:movies_app/presentation/providers/movies/movies_provider.dart';

final moviesSlideshowProvider = Provider<List<MovieEntity>>(
  (ref) {
    final List<MovieEntity> nowPlayingMovies =
        ref.watch(nowPlayingMoviesProvider);
    if (nowPlayingMovies.isEmpty) {
      return [];
    }
    return nowPlayingMovies.sublist(0, 6);
  },
);
