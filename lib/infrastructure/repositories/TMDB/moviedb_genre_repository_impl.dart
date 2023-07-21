import 'package:movies_app/domain/domain.dart';

import '../../../domain/repositories/genres_repository.dart';

class MovieDBGenreRepositoryImpl extends GenresRepository {
  final GenresDatasource datasource;

  MovieDBGenreRepositoryImpl(this.datasource);

  @override
  Future<List<GenresEntity>> getGenres() {
    return datasource.getGenres();
  }
}
