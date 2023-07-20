
import '../domain.dart';

abstract class GenresRepository {
  Future<List<GenresEntity>> getGenres();
}