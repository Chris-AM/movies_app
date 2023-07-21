import 'package:dio/dio.dart';
import 'package:movies_app/config/config.dart';
import 'package:movies_app/domain/datasources/genres_datasource.dart';
import 'package:movies_app/domain/entities/genres_entity.dart';
import 'package:movies_app/infrastructure/infrastructure.dart';

class MovieDBGenresDatasource extends GenresDatasource {
  final int movieLanguageIndex;

  final Dio dio = Environment.globalDio;

  MovieDBGenresDatasource(this.movieLanguageIndex);

  List<GenresEntity> _genresPetition(Map<String, dynamic> response) {
    final GenresResponse genresResponse = GenresResponse.fromJson(response);
    final genres = genresResponse.genres
        .map((genreDB) => TMDBMapper.genreDBToEntity(genreDB))
        .toList();
    return genres;
  }

  @override
  Future<List<GenresEntity>> getGenres() async {
    final response = await dio.get(
      '/genre/movie/list',
      queryParameters: {
        'language':
            await GetMovieLanguageHelper.getMovieLanguage(movieLanguageIndex),
      },
    );
    final List<GenresEntity> genres = _genresPetition(response.data);
    return genres;
  }
}
