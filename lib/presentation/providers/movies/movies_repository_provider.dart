import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/infrastructure/datasources/moviedb_datasource.dart';
import 'package:movies_app/infrastructure/repositories/moviedb_repository_impl.dart';

final Provider<MovieRepositoryImpl> movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MovieDBDataSource());
});
