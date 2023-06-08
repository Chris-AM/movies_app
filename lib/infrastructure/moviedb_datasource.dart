import 'package:dio/dio.dart';
import 'package:movies_app/config/constants/environment.dart';
import 'package:movies_app/domain/datasources/movies_datasource.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';

class MovieDBDataSource extends MoviesDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.tmdbKey,
        'language': 'en-US',
      },
    ),
  );
  @override
  Future<List<MovieEntity>> getNowInCinema({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final List<MovieEntity> movies = [];
    return movies;
  }
}
