import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/infrastructure/infrastructure.dart';

import 'movies_languages_provider.dart';

final Provider<MovieRepositoryImpl> movieRepositoryProvider = Provider((ref) {
  final int movieLanguageIndex = ref.watch(moviesLanguageIndexProvider);
  return MovieRepositoryImpl(MovieDBDataSource(movieLanguageIndex));
});
