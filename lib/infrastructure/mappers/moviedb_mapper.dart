import 'package:movies_app/domain/domain.dart';
import '../infrastructure.dart';

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
        releaseDate: response.releaseDate != null
            ? response.releaseDate!
            : DateTime.now(),
        title: response.title,
        video: response.video,
        voteAverage: response.voteAverage,
        voteCount: response.voteCount,
      );

  static MovieEntity movieDetail(MovieDetail movieDetail) => MovieEntity(
        adult: movieDetail.adult,
        backdropPath: movieDetail.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500${movieDetail.backdropPath}'
            : 'https://sd.keepcalms.com/i/keep-calm-poster-not-found.png',
        genreIds: movieDetail.genres.map((e) => e.name).toList(),
        id: movieDetail.id,
        originalLanguage: movieDetail.originalLanguage,
        originalTitle: movieDetail.originalTitle,
        overview: movieDetail.overview,
        popularity: movieDetail.popularity,
        posterPath: movieDetail.posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500${movieDetail.posterPath}'
            : 'https://sd.keepcalms.com/i/keep-calm-poster-not-found.png',
        releaseDate: movieDetail.releaseDate,
        title: movieDetail.title,
        video: movieDetail.video,
        voteAverage: movieDetail.voteAverage,
        voteCount: movieDetail.voteCount,
      );

  static GenresEntity genreDBToEntity(Genre response) => GenresEntity(
        id: response.id,
        name: response.name,
      );
}
