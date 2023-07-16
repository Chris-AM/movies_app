import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/domain.dart';
import 'package:movies_app/presentation/providers/cast/cast_repository_provider.dart';

final castByMovieProvider =
    StateNotifierProvider<CastMapNotifier, Map<String, List<ActorEntity>>>(
  (ref) {
    final fetchCast = ref.watch(castRepositoryProvider);
    return CastMapNotifier(castCallback: fetchCast.getActorByMovie);
  },
);

typedef GetCastCallBack = Future<List<ActorEntity>> Function(
  String movieId,
);

class CastMapNotifier extends StateNotifier<Map<String, List<ActorEntity>>> {
  final GetCastCallBack castCallback;

  CastMapNotifier({
    required this.castCallback,
  }) : super({});

  Future<void> loadCast(String movieId) async {
    if (state[movieId] != null) return;
    final List<ActorEntity> actor = await castCallback(movieId);
    state = {...state, movieId: actor};
  }
}
