import 'package:movies_app/domain/domain.dart';

abstract class ActorsDataSource {
  Future<List<ActorEntity>> getActorsByMovie(String movieId);
}