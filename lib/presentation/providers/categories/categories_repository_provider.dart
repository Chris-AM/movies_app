import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import '/infrastructure/infrastructure.dart';

final Provider<MovieDBGenreRepositoryImpl> movieDBGenreRepositoryProvider =
    Provider((ref) {
  final int movieLanguageIndex = ref.watch(moviesLanguageIndexProvider);
  return MovieDBGenreRepositoryImpl(
      MovieDBGenresDatasource(movieLanguageIndex));
});
