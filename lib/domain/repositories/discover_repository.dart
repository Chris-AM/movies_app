import 'package:movies_app/domain/domain.dart';

abstract class DiscoverRepository {
  Future<List<MovieEntity>> getMovieByGenreId(int genreId);
}
