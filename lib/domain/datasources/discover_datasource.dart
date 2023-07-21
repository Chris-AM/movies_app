import 'package:movies_app/domain/domain.dart';

abstract class DiscoverDatasource {
  Future<List<MovieEntity>> getMovieByGenreId(int genreId);
}
