import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../providers/providers.dart';

class LanguageSelectionView extends ConsumerWidget {
  final String title; // The title of the screen
  const LanguageSelectionView({
    super.key,
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
            ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
            ref.read(popularMoviesProvider.notifier).loadNextPage();
            ref.read(upComingMoviesProvider.notifier).loadNextPage();
            ref.read(topRatedMoviesProvider.notifier).loadNextPage();
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
