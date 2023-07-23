import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/infrastructure/infrastructure.dart';
import 'package:movies_app/presentation/providers/providers.dart';

final Provider<MovieDBDiscoverRepositoryImpl> discoverRepositoryProvider =
    Provider((ref) {
  final movieLanguageIndex = ref.watch(moviesLanguageIndexProvider);
  return MovieDBDiscoverRepositoryImpl(
      MovieDBDiscoverDatasource(movieLanguageIndex));
});
