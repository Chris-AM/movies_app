import 'package:movies_app/domain/entities/movie_entity.dart';

abstract class MoviesDataSource {
  Future<List<MovieEntity>> getNowPlaying({int page = 1, int index = 0});
}
