import 'package:isar/isar.dart';
import 'package:movies_app/domain/domain.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDataSource {
  late Future<Isar> isarDb;

  IsarDatasource() {
    isarDb = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieEntitySchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    final isar = await isarDb;
    final MovieEntity? findFavMovies =
        await isar.movieEntities.filter().idEqualTo(movieId).findFirst();
    return findFavMovies != null;
  }

  @override
  Future<List<MovieEntity>> loadMovies({int limit = 10, int offset = 0}) async {
    final isar = await isarDb;
    final Future<List<MovieEntity>> query =
        isar.movieEntities.where().offset(offset).limit(limit).findAll();
    return query;
  }

  @override
  Future<void> toggleFavorite(MovieEntity movie) async {
    final isar = await isarDb;
    final findFavMovies =
        await isar.movieEntities.filter().idEqualTo(movie.id).findFirst();

    if (findFavMovies != null) {
      isar.writeTxnSync(
        () => isar.movieEntities.deleteSync(findFavMovies.isarId!),
      );
      return;
    }
    isar.writeTxnSync(() => isar.movieEntities.putSync(movie));
  }
}
