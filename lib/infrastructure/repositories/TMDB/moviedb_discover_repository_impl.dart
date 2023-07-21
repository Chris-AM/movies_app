import 'package:movies_app/domain/domain.dart';

class MovieDBDiscoverRepositoryImpl extends DiscoverRepository {
  final DiscoverDatasource dataSource;

  MovieDBDiscoverRepositoryImpl(this.dataSource);

  @override
  Future<List<MovieEntity>> getMovieByGenreId({
    required int genreId,
    required int page,
  }) {
    return dataSource.getMovieByGenreId(
      genreId: genreId,
      page: page,
    );
  }
}
