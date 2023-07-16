import 'package:movies_app/domain/datasources/local_storage_datasource.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDataSource dataSource;

  LocalStorageRepositoryImpl(this.dataSource);

  @override
  Future<bool> isFavorite(int movieId) {
    return dataSource.isFavorite(movieId);
  }

  @override
  Future<List<MovieEntity>> loadMovies({int limit = 10, int offset = 0}) {
    return dataSource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<bool> toggleFavorite(MovieEntity movie) {
    return dataSource.toggleFavorite(movie);
  }
}
