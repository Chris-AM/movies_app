import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/infrastructure/datasources/moviedb_actors_datasource.dart';
import 'package:movies_app/infrastructure/repositories/moviedb_cast_repository_impl.dart';

final castRepositoryProvider = Provider((ref) {
  return MovieDBCastRepositoryImpl(MovieDBActorsDataSource());
});
