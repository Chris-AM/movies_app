//* Dart/Flutter imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
//* Own Imports
import 'package:movies_app/presentation/providers/movies/movies_languages_provider.dart';
import 'package:movies_app/presentation/providers/movies/movies_provider.dart';

// This is a stateless widget that displays the movie language selection screen
class MovieLanguageSelectionScreen extends StatelessWidget {
  static const String name =
      'movie_language_selection'; // The name of the screen
  final String title = 'Movie Language Selection'; // The title of the screen
  const MovieLanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _LanguageSelectionView(
          title: title,
        ), // Display the language selection view
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop();
        },
        child: Platform.isIOS
            ? const Icon(Icons.arrow_back_ios_new_rounded)
            : const Icon(Icons.arrow_back_rounded),
      ),
    );
  }
}

// This is a consumer widget that displays the language selection view
class _LanguageSelectionView extends ConsumerWidget {
  final String title; // The title of the screen
  const _LanguageSelectionView({
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, String> languagesMapState = ref.watch(
        moviesLanguagesProvider); // Get the map of language names to codes from the state
    final int selectedLanguage = ref.watch(
        moviesLanguageIndexProvider); // Get the selected language index from the state
    return ListView.builder(
      itemCount: languagesMapState
          .length, // Set the number of items to the length of the map
      itemBuilder: (context, index) {
        // Get the language name and code at the current index
        final entries = languagesMapState.entries.toList()[index];
        return LanguageRadioListTile(
          languageNames: entries.key,
          codes: entries.value,
          selectedLanguage: selectedLanguage,
          value: index,
          onChanged: (value) {
            // Update the selected language index in the state
            ref.read(moviesLanguageIndexProvider.notifier).state = index;
            // Update the movies state with the selected language
            ref
                .read(nowPlayingMoviesProvider.notifier)
                .setMoviesLanguage(index);
            ref.read(popularMoviesProvider.notifier).setMoviesLanguage(index);
            ref.read(upComingMoviesProvider.notifier).setMoviesLanguage(index);
            ref.read(topRatedMoviesProvider.notifier).setMoviesLanguage(index);
          },
        );
      },
    );
  }
}

// This is a stateless widget that displays a radio button for a language
class LanguageRadioListTile extends StatelessWidget {
  final int selectedLanguage; // The currently selected language index
  final String languageNames; // The name of the language
  final String codes; // The code of the language
  final int value; // The index of the language
  final Function(int?)
      onChanged; // The callback function when the language is changed

  const LanguageRadioListTile({
    super.key,
    required this.selectedLanguage,
    required this.languageNames,
    required this.codes,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(languageNames),
      subtitle: Text(codes),
      groupValue: selectedLanguage,
      value: value,
      onChanged: onChanged,
    );
  }
}
