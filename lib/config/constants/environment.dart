import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String tmdbKey = dotenv.get('TMDB_KEY');
}
