import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String tmdbKey = dotenv.get('TMDB_KEY');
  // static String urlBase = 'http://api.themoviedb.org/3';
  static String urlBase = dotenv.get('BASE_URL');

  static Dio globalDio = Dio(
    BaseOptions(
      baseUrl: urlBase,
      queryParameters: {
        'api_key': tmdbKey,
      },
    ),
  );
}
