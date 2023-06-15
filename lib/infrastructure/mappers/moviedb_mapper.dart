import 'package:movies_app/domain/entities/movie_entity.dart';
import 'package:movies_app/infrastructure/models/moviedb/moviedb_result.dart';

class TMDBMapper {
  static MovieEntity movieDBToEntity(MovieDBResponse response) => MovieEntity(
        adult: response.adult,
        backdropPath: response.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500${response.backdropPath}'
            : 'https://sd.keepcalms.com/i/keep-calm-poster-not-found.png',
        genreIds: response.genreIds.map((e) => e.toString()).toList(),
        id: response.id,
        originalLanguage: response.originalLanguage,
        originalTitle: response.originalTitle,
        overview: response.overview,
        popularity: response.popularity,
        posterPath: response.posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500${response.posterPath}'
            : 'https://sd.keepcalms.com/i/keep-calm-poster-not-found.png',
        releaseDate: response.releaseDate,
        title: response.title,
        video: response.video,
        voteAverage: response.voteAverage,
        voteCount: response.voteCount,
      );
}
