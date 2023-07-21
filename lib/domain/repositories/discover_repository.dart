import 'package:movies_app/domain/domain.dart';

abstract class DiscoverRepository {
  Future<List<MovieEntity>> getMovieByGenreId({
    required int genreId,
    required int page,
  });
}
