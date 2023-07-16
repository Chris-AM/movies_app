import 'package:movies_app/domain/domain.dart';

abstract class LocalStorageRepository {
  Future<void> toggleFavorite(MovieEntity movie);
  Future<bool> isFavorite(int movieId);
  Future<List<MovieEntity>> loadMovies({int limit = 10, int offset = 0});
}
