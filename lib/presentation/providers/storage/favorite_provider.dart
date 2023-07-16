import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/presentation/providers/providers.dart';

final AutoDisposeFutureProviderFamily<bool, int> isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepo = ref.watch(localStorageRepositoryProvider);

  return localStorageRepo.isFavorite(movieId);
});
