import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/infrastructure/infrastructure.dart';

final Provider<MovieRepositoryImpl> movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MovieDBDataSource());
});
