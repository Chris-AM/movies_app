import 'package:movies_app/domain/entities/movie_entity.dart';

abstract class MoviesRepository {
  Future<List<MovieEntity>> getNowPlaying(int page);

  Future<List<MovieEntity>> getPopular(int page);

  Future<List<MovieEntity>> getUpcoming(int page);

  Future<List<MovieEntity>> topRated(int page);

  Future<MovieEntity> getMovieById(String movieId);

  Future<List<MovieEntity>> searchMovies(String searchTerm);
}
