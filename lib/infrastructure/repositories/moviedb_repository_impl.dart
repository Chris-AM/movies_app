import 'package:movies_app/domain/datasources/movies_datasource.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDataSource dataSource;

  MovieRepositoryImpl(this.dataSource);
  @override
  Future<List<MovieEntity>> getNowPlaying(
      {int page = 1, int movieLanguageIndex = 0}) {
    return dataSource.getNowPlaying(
      page: page,
      movieLanguageIndex: movieLanguageIndex,
    );
  }

  @override
  Future<List<MovieEntity>> getPopular(
      {int page = 1, int movieLanguageIndex = 0}) {
    return dataSource.getPopular(
      page: page,
      movieLanguageIndex: movieLanguageIndex,
    );
  }

  @override
  Future<List<MovieEntity>> getUpcoming(
      {int page = 1, int movieLanguageIndex = 0}) {
    return dataSource.getUpcoming(
      page: page,
      movieLanguageIndex: movieLanguageIndex,
    );
  }

  @override
  Future<List<MovieEntity>> topRated(
      {int page = 1, int movieLanguageIndex = 0}) {
    return dataSource.topRated(
      page: page,
      movieLanguageIndex: movieLanguageIndex,
    );
  }

  @override
  Future<MovieEntity> getDetail(
      {required String movieId, int movieLanguageIndex = 0}) {
    return dataSource.getMovieById(
      movieId: movieId,
      movieLanguageIndex: movieLanguageIndex,
    );
  }
}
