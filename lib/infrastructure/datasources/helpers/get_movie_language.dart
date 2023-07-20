import 'package:flutter/material.dart';
import 'package:devicelocale/devicelocale.dart';

import '../../infrastructure.dart';


class GetMovieLanguageHelper {
  static Future<String> getMovieLanguage(int movieLanguageIndex) async {
    // if(movieLanguageIndex)
    List<Locale?> locale = await Devicelocale.preferredLanguagesAsLocales;

    final String movieLanguage =
        moviesLanguagesMapper.values.toList()[movieLanguageIndex];
    final String language = locale[0].toString().replaceAll('_', '-');
    final String deviceLanguage = moviesLanguagesMapper.values.toList()[0];
    if (movieLanguage == deviceLanguage) {
      return language;
    }
    return movieLanguage;
  }
}