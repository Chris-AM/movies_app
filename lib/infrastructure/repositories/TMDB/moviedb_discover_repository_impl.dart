import 'package:movies_app/domain/domain.dart';

class MovieDBDiscoverRepositoryImpl extends DiscoverRepository {
  final DiscoverDatasource dataSource;

  MovieDBDiscoverRepositoryImpl(this.dataSource);

  @override
  Future<List<MovieEntity>> getMovieByGenreId(int genreId) {
    return dataSource.getMovieByGenreId(genreId);
  }
}
