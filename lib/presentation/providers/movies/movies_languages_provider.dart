import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/infrastructure/mappers/mappers.dart';

// Manage the languages of the movies state
// get the mapper state
final Provider<Map<String, String>> moviesLanguagesProvider =
    Provider<Map<String, String>>(
  (ref) => moviesLanguagesMapper,
);

final StateProvider<int> moviesLanguageIndexProvider = StateProvider<int>(
  (ref) {
    print('index in the state: $moviesLanguageIndex');
    return moviesLanguageIndex;
  },
);
