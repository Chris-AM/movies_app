import 'package:dio/dio.dart';
import 'package:movies_app/config/constants/environment.dart';
import 'package:movies_app/domain/datasources/actors_datasource.dart';
import 'package:movies_app/domain/entities/actor_entity.dart';
import 'package:movies_app/infrastructure/mappers/actor_mapper.dart';
import 'package:movies_app/infrastructure/models/moviedb/moviedb_actors.dart';

class MovieDBActorsDataSource extends ActorsDataSource {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.tmdbKey,
      },
    ),
  );

  @override
  Future<List<ActorEntity>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final CreditsResponse creditsResponse =
        CreditsResponse.fromJson(response.data);
    final List<ActorEntity> cast = creditsResponse.cast
        .map((actor) => ActorMapper.castToEntity(actor))
        .toList();

    return cast;
  }
}
