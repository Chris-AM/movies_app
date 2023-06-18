import 'package:movies_app/domain/entities/entities.dart';

abstract class ActorsRepository {
  Future<List<ActorEntity>> getActorByMovie(String movieId);
}
