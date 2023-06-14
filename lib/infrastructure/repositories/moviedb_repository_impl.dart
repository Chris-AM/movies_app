import 'package:movies_app/domain/datasources/movies_datasource.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDataSource dataSource;

  MovieRepositoryImpl(this.dataSource);
  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1, int index = 0}) {
    return dataSource.getNowPlaying(
      page: page,
      index: index,
    );
  }

  @override
  Future<List<MovieEntity>> getPopular({int page = 1, int index = 0}) {
    return dataSource.getPopular(
      page: page,
    );
  }
}
