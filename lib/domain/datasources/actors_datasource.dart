import 'package:movies_app/domain/entities/entities.dart';

abstract class ActorsDataSource {
  Future<List<ActorEntity>> getActorsByMovie(String movieId);
}