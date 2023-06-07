import 'package:movies_app/domain/entities/movie_entity.dart';

abstract class MoviesRepository {
  Future<List<MovieEntity>> getNowInCinema({int page = 1});
}
