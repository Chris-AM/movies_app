import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/presentation/providers/providers.dart';
import '../../../domain/domain.dart';

final FutureProviderFamily<List<MovieEntity>, int> similarMoviesProvider =
    FutureProviderFamily((ref, int movieId) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getSimilarMovies(movieId);
});
