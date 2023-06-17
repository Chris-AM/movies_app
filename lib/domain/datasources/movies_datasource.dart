import 'package:movies_app/domain/entities/movie_entity.dart';

abstract class MoviesDataSource {
  Future<List<MovieEntity>> getNowPlaying({
    int page = 1,
    int movieLanguageIndex = 0,
  });
  Future<List<MovieEntity>> getPopular({
    int page = 1,
    int movieLanguageIndex = 0,
  });
  Future<List<MovieEntity>> getUpcoming({
    int page = 1,
    int movieLanguageIndex = 0,
  });
  Future<List<MovieEntity>> topRated({
    int page = 1,
    int movieLanguageIndex = 0,
  });
  Future<MovieEntity> getMovieById({
    String movieId,
    int movieLanguageIndex = 0,
  });
}
