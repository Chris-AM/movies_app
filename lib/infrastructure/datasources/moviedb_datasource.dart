//* Flutter Imports
import 'package:dio/dio.dart';
//* Own Imports
import 'package:movies_app/config/constants/environment.dart';
import 'package:movies_app/domain/datasources/movies_datasource.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/infrastructure/mappers/moviedb_mapper.dart';
import 'package:movies_app/infrastructure/models/moviedb/moviedb_response.dart';

class MovieDBDataSource extends MoviesDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.tmdbKey,
      },
    ),
  );

  @override
  Future<List<MovieEntity>> getNowPlaying(
      {int page = 1, String moviesLanguage = 'en-US'}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {
        'language': moviesLanguage,
      },
    );
    final TmdbResponse tmdbResponse = TmdbResponse.fromJson(response.data);
    final List<MovieEntity> movies = tmdbResponse.results
        .where((movieDB) => movieDB.posterPath != 'no-poster')
        .map((movieDB) => MovieMapper.movieDBToEntity(movieDB))
        .toList();
    return movies;
  }
}
