//* Flutter Imports
import 'package:dio/dio.dart';
//* Own Imports
import 'package:movies_app/config/config.dart';
import 'package:movies_app/domain/domain.dart';
import 'package:movies_app/infrastructure/infrastructure.dart';

class MovieDBDataSource extends MoviesDataSource {
  final int movieLanguageIndex;

  final Dio dio = Environment.globalDio;

  MovieDBDataSource(this.movieLanguageIndex);

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
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {
        'page': page,
        'language':
            await GetMovieLanguageHelper.getMovieLanguage(movieLanguageIndex),
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
        'language':
            await GetMovieLanguageHelper.getMovieLanguage(movieLanguageIndex),
      },
    );
    final List<MovieEntity> movies = _moviesPetition(response.data);
    return movies;
  }

  @override
  Future<List<MovieEntity>> getUpcoming(int page) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {
        'page': page,
        'language':
            await GetMovieLanguageHelper.getMovieLanguage(movieLanguageIndex),
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
        'language':
            await GetMovieLanguageHelper.getMovieLanguage(movieLanguageIndex),
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
        'language':
            await GetMovieLanguageHelper.getMovieLanguage(movieLanguageIndex),
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
        'language':
            await GetMovieLanguageHelper.getMovieLanguage(movieLanguageIndex),
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Movie $searchTerm not found');
    }
    return _moviesPetition(response.data);
  }

  @override
  Future<List<VideoEntity>> getVideosFromYouTube(int movieId) async {
    final response = await dio.get(
      '/movie/$movieId/videos',
      queryParameters: {
        'language':
            await GetMovieLanguageHelper.getMovieLanguage(movieLanguageIndex),
      },
    );
    final movieDBVideosResponse = MoviedbVideosResponse.fromJson(response.data);
    final List<VideoEntity> videos = <VideoEntity>[];
    for (final result in movieDBVideosResponse.results) {
      if (result.site == 'YouTube') {
        final video = VideoMapper.moviedbVideoToEntity(result);
        videos.add(video);
      }
    }
    return videos;
  }

  @override
  Future<List<MovieEntity>> getSimilarMovies(int movieId) async {
    final response = await dio.get(
      '/movie/$movieId/similar',
      queryParameters: {
        'language':
            await GetMovieLanguageHelper.getMovieLanguage(movieLanguageIndex),
      },
    );
    final List<MovieEntity> movies = _moviesPetition(response.data);
    return movies;
  }
}
