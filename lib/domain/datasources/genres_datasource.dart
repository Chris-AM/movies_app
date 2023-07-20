import 'package:movies_app/domain/domain.dart';

abstract class GenresDatasource {
  Future<List<GenresEntity>> getGenres();
}
