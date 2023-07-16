import 'package:movies_app/domain/entities/movie_entity.dart';

abstract class LocalStorageDataSource {
  Future<bool> toggleFavorite(MovieEntity movie);
  Future<bool> isFavorite(int movieId);
  Future<List<MovieEntity>> loadMovies({int limit = 10, int offset = 0});
}
