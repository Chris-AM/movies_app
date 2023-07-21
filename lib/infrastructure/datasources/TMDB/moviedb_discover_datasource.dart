import 'package:dio/dio.dart';
import 'package:movies_app/config/config.dart';
import 'package:movies_app/domain/domain.dart';
import 'package:movies_app/infrastructure/infrastructure.dart';

class MovieDBDiscoverDatasource extends DiscoverDatasource {
  final int movieLanguageIndex;

  final Dio dio = Environment.globalDio;
  MovieDBDiscoverDatasource(this.movieLanguageIndex);

  List<MovieEntity> _moviesPetition(Map<String, dynamic> response) {
    final TmdbResponse tmdbResponse = TmdbResponse.fromJson(response);
    final List<MovieEntity> movies = tmdbResponse.results
        .where((movie) => movie.posterPath != 'no-post')
        .map((movie) => TMDBMapper.movieDBToEntity(movie))
        .toList();
    return movies;
  }

  @override
  Future<List<MovieEntity>> getMovieByGenreId({
    required int genreId,
    required int page,
  }) async {
    final response = await dio.get(
      '/discover/movie',
      queryParameters: {
        'with_genres': genreId,
        'page': page,
      },
    );

    final List<MovieEntity> movies = _moviesPetition(response.data);
    return movies;
  }
}
