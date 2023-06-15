import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/presentation/providers/providers.dart';

final appInitialLoadProvider = Provider<bool>((ref) {
  final movieProviders = [
    ref.watch(nowPlayingMoviesProvider),
    ref.watch(popularMoviesProvider),
    ref.watch(upComingMoviesProvider),
    ref.watch(topRatedMoviesProvider),
  ];
  return movieProviders.any((movies) => movies.isEmpty);
});
