import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/presentation/providers/movies/movies_languages_provider.dart';
import 'package:movies_app/presentation/screens/widgets/widgets.dart';

class MovieLanguageSelectionScreen extends StatelessWidget {
  static const String name = 'movie_language_selection';
  final String title = 'Movie Language Selection';
  const MovieLanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(appBarTitle: title, showSettingsButton: false),
      body: Center(
        child: _LanguageSelectionView(title: title),
      ),
    );
  }
}

class _LanguageSelectionView extends ConsumerWidget {
  final String title;
  const _LanguageSelectionView({
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, String> languagesMapState =
        ref.watch(moviesLanguagesProvider);
    final int selectedLanguage = ref.watch(moviesLanguageIndexProvider);
    print(
      'states at view: { selectedLanguage:  $selectedLanguage }',
    );
    return ListView.builder(
      itemCount: languagesMapState.length,
      itemBuilder: (context, index) {
        final String languagesNames = languagesMapState.keys.toList()[index];
        final String languagesCodes = languagesMapState.values.toList()[index];
        return RadioListTile(
          title: Text(languagesNames),
          subtitle: Text(languagesCodes),
          groupValue: selectedLanguage,
          value: index,
          onChanged: (value) {
            ref.read(moviesLanguageIndexProvider.notifier).state = index;
          },
        );
      },
    );
  }
}
