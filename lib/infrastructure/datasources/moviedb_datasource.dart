//* Flutter Imports
import 'package:dio/dio.dart';
//* Own Imports
import 'package:movies_app/config/constants/environment.dart';
import 'package:movies_app/domain/datasources/movies_datasource.dart';
import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/infrastructure/infrastructure.dart';

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
  Future<List<MovieEntity>> getNowPlaying(int page) async {
    print('page: $page');
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {
        'page': page,
        'language': moviesLanguagesMapper.values.toList()[1],
      },
    );
    final List<MovieEntity> movies = _moviesPetition(response.data);
    return movies;
  }

  @override
  Future<List<MovieEntity>> getPopular(int page) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {
        'page': page,
        'language': moviesLanguagesMapper.values.toList()[1],
      },
    );

    final List<MovieEntity> movies = _moviesPetition(response.data);
    return movies;
  }

  @override
  Future<List<MovieEntity>> getUpcoming(int page) async {
    print('page: $page');
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {
        'page': page,
        'language': moviesLanguagesMapper.values.toList()[1],
      },
    );

    final List<MovieEntity> movies = _moviesPetition(response.data);
    return movies;
  }

  @override
  Future<List<MovieEntity>> topRated(int page) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {
        'page': page,
        'language': moviesLanguagesMapper.values.toList()[1],
      },
    );

    final List<MovieEntity> movies = _moviesPetition(response.data);
    return movies;
  }

  @override
  Future<MovieEntity> getMovieById(String movieId) async {
    final response = await dio.get(
      '/movie/$movieId',
      queryParameters: {
        'language': moviesLanguagesMapper.values.toList()[0],
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Movie with $movieId not found');
    }
    final MovieDetail foundMovie = MovieDetail.fromJson(response.data);
    final MovieEntity movie = TMDBMapper.movieDetail(foundMovie);
    return movie;
  }

  @override
  Future<List<MovieEntity>> searchMovies(String searchTerm) async {
    if (searchTerm.isEmpty) {
      return [];
    }
    final response = await dio.get(
      '/search/movie',
      queryParameters: {
        'query': searchTerm,
        'language': moviesLanguagesMapper.values.toList()[0],
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Movie $searchTerm not found');
    }
    return _moviesPetition(response.data);
  }
}
