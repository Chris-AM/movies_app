import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/domain.dart';
import 'package:movies_app/presentation/providers/providers.dart';

final FutureProviderFamily<List<VideoEntity>, int> movieVideosProvider =
    FutureProvider.family((ref, int movieId) {
  final movieProvider = ref.watch(movieRepositoryProvider);
  return movieProvider.getVideosFromYouTube(movieId);
});
