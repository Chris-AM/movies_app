import 'package:movies_app/domain/datasources/actors_datasource.dart';
import 'package:movies_app/domain/entities/actor_entity.dart';
import 'package:movies_app/domain/repositories/actors_repository.dart';

class MovieDBCastRepositoryImpl extends ActorsRepository {
  final ActorsDataSource dataSource;

  MovieDBCastRepositoryImpl(this.dataSource);
  @override
  Future<List<ActorEntity>> getActorByMovie(String movieId) {
    return dataSource.getActorsByMovie(movieId);
  }
}
