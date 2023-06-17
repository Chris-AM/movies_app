//* Flutter Imports
import 'package:dio/dio.dart';
//* Own Imports
import 'package:movies_app/config/constants/environment.dart';
import 'package:movies_app/domain/datasources/movies_datasource.dart';
import 'package:movies_app/domain/entities/movie_detail.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/infrastructure/mappers/mappers.dart';
import 'package:movies_app/infrastructure/models/moviedb/moviedb_response.dart';

class MovieDBDataSource extends MoviesDataSource {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.tmdbKey,
      },
    ),
  );

  List<MovieEntity> _moviesPetition(Map<String, dynamic> response) {
    final TmdbResponse tmdbResponse = TmdbResponse.fromJson(response);
    final List<MovieEntity> movies = tmdbResponse.results
        .where((movieDB) => movieDB.posterPath != 'no-poster')
        .map((movieDB) => TMDBMapper.movieDBToEntity(movieDB))
        .toList();
    return movies;
  }

  @override
  Future<List<MovieEntity>> getNowPlaying(
      {int page = 1, int movieLanguageIndex = 0}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {
        'page': page,
        'language': moviesLanguagesMapper.values.toList()[movieLanguageIndex],
      },
    );
    final List<MovieEntity> movies = _moviesPetition(response.data);
    return movies;
  }

  @override
  Future<List<MovieEntity>> getPopular(
      {int page = 1, int movieLanguageIndex = 0}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {
        'page': page,
        'language': moviesLanguagesMapper.values.toList()[movieLanguageIndex],
      },
    );

    final List<MovieEntity> movies = _moviesPetition(response.data);
    return movies;
  }

  @override
  Future<List<MovieEntity>> getUpcoming({
    int page = 1,
    int movieLanguageIndex = 0,
  }) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {
        'page': page,
        'language': moviesLanguagesMapper.values.toList()[movieLanguageIndex],
      },
    );

    final List<MovieEntity> movies = _moviesPetition(response.data);
    return movies;
  }

  @override
  Future<List<MovieEntity>> topRated(
      {int page = 1, int movieLanguageIndex = 0}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {
        'page': page,
        'language': moviesLanguagesMapper.values.toList()[movieLanguageIndex],
      },
    );

    final List<MovieEntity> movies = _moviesPetition(response.data);
    return movies;
  }

  @override
  Future<MovieEntity> getMovieById(
      {required String movieId, int movieLanguageIndex = 0}) async {
    final response = await dio.get(
      '/movie/$movieId',
      queryParameters: {
        'language': moviesLanguagesMapper.values.toList()[movieLanguageIndex],
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Movie with $movieId not found');
    }
    final MovieDetail foundMovie = MovieDetail.fromJson(response.data);
    final MovieEntity movie = TMDBMapper.movieDetail(foundMovie);
    return movie;
  }
}
