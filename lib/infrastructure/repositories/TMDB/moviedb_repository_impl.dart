import 'package:movies_app/domain/datasources/movies_datasource.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/domain/entities/video_entity.dart';
import 'package:movies_app/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDataSource dataSource;

  MovieRepositoryImpl(this.dataSource);
  @override
  Future<List<MovieEntity>> getNowPlaying(int page) {
    return dataSource.getNowPlaying(page);
  }

  @override
  Future<List<MovieEntity>> getPopular(int page) {
    return dataSource.getPopular(page);
  }

  @override
  Future<List<MovieEntity>> getUpcoming(int page) {
    return dataSource.getUpcoming(page);
  }

  @override
  Future<List<MovieEntity>> topRated(int page) {
    return dataSource.topRated(page);
  }

  @override
  Future<MovieEntity> getMovieById(String movieId) {
    return dataSource.getMovieById(movieId);
  }

  @override
  Future<List<MovieEntity>> searchMovies(String searchTerm) {
    return dataSource.searchMovies(searchTerm);
  }

  @override
  Future<List<VideoEntity>> getVideosFromYouTube(int movieId) {
    return dataSource.getVideosFromYouTube(movieId);
  }

  @override
  Future<List<MovieEntity>> getSimilarMovies(int movieId) {
    return dataSource.getSimilarMovies(movieId);
  }
}
