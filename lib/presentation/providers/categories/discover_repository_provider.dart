import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/presentation/providers/providers.dart';

import '../../../infrastructure/infrastructure.dart';

final Provider<MovieDBDiscoverRepositoryImpl> discoverRepositoryProvider =
    Provider((ref) {
  final int movieLanguageIndex = ref.watch(moviesLanguageIndexProvider);
  return MovieDBDiscoverRepositoryImpl(
      MovieDBDiscoverDatasource(movieLanguageIndex));
});
