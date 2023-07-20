import 'dart:convert';

import 'movie_detail.dart';

GenresResponse genresResponseFromJson(String str) => GenresResponse.fromJson(json.decode(str));

String genresResponseToJson(GenresResponse data) => json.encode(data.toJson());

class GenresResponse {
    final List<Genre> genres;

    GenresResponse({
        required this.genres,
    });

    factory GenresResponse.fromJson(Map<String, dynamic> json) => GenresResponse(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    };
}

