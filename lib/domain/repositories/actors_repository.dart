import 'package:movies_app/domain/domain.dart';

abstract class ActorsRepository {
  Future<List<ActorEntity>> getActorByMovie(String movieId);
}
